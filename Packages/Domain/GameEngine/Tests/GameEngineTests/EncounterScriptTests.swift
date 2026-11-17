import Foundation
@testable import GameEngine
import Scripting
import Testing
import Yams

private let courierPath = "events/collect-parcel/courier.yaml"
private let items: Set<String> = ["coin", "parcel"]

private func compileCourier(replacing old: String? = nil, with new: String = "") throws -> EncounterScript {
    let campaign = URL(filePath: #filePath).deletingLastPathComponent()
        .appending(path: "../../../../../Fixtures/Campaigns/LastTrain")
    var yaml = try String(contentsOf: campaign.appending(path: courierPath), encoding: .utf8)
    if let old {
        try #require(yaml.contains(old))
        yaml = yaml.replacingOccurrences(of: old, with: new)
    }
    let document = try #require(try compose(yaml: yaml))
    let script = try #require(document["script"]?.scalar)
    try #require(script.style == .literal)
    let header = try #require(script.mark)
    let lines = yaml.components(separatedBy: "\n")
    let firstLine = try #require(lines.dropFirst(header.line).first)
    let indent = firstLine.prefix(while: { $0 == " " }).count
    let origin = ScriptLocation(path: courierPath, line: header.line + 1, column: indent + 1)
    return try EncounterScript.compile(script.string, at: origin, itemIDs: items)
}

private actor EncounterTestSession: EncounterInventory {
    let answer: Int
    let failRemoval: Bool
    private(set) var coins: Int
    private(set) var choices: [EncounterChoice] = []
    private(set) var operations: [String] = []
    private(set) var messages: [String] = []

    nonisolated var context: EncounterContext {
        EncounterContext(inventory: self, choose: { await self.select($0) }, say: { await self.show($0) })
    }

    init(coins: Int, answer: Int, failRemoval: Bool = false) {
        self.coins = coins
        self.answer = answer
        self.failRemoval = failRemoval
    }

    func select(_ choices: [EncounterChoice]) -> Int {
        self.choices = choices
        return answer
    }

    func show(_ message: String) {
        messages.append(message)
    }

    func itemCount(_ id: String, in target: InventoryTarget) -> Int {
        #expect(target == .current)
        #expect(id == "coin")
        return coins
    }

    func addItem(_ id: String, count: Int, in target: InventoryTarget) {
        #expect(target == .current)
        operations.append("+\(count) \(id)")
    }

    func removeItem(_ id: String, count: Int, in target: InventoryTarget) throws {
        #expect(target == .current)
        if failRemoval { throw ScriptError("Inventory unavailable") }
        coins -= count
        operations.append("-\(count) \(id)")
    }
}

@Test func courierPaymentAndRefusalUseTheSameCompiledScript() async throws {
    let courier = try compileCourier()
    for (coins, selection) in [(5, 0), (5, 1), (4, 1)] {
        let session = EncounterTestSession(coins: coins, answer: selection)
        try await courier.run(in: session.context)
        let choices = await session.choices
        try #require(choices.count == 2)
        #expect(choices.map(\.title) == ["Заплатить 5 монет", "Отказаться"])
        #expect(choices[0].isAvailable == (coins >= 5))
        #expect(choices[0].hint == (coins >= 5 ? nil : "Нужно 5 монет"))
        #expect(choices[1].isAvailable)
        #expect(await session.operations == (selection == 0 ? ["-5 coin", "+1 parcel"] : []))
        #expect(await session.coins == (selection == 0 ? 0 : coins))
        #expect(await session.messages == (selection == 0 ? [] : ["Тогда заберёте посылку на почте."]))
    }
}

@Test func failingCourierPaymentPreservesTheInnermostCallPosition() async throws {
    let courier = try compileCourier()
    let session = EncounterTestSession(coins: 5, answer: 0, failRemoval: true)
    await #expect(throws: ScriptDiagnostic(
        location: .init(path: courierPath, line: 13, column: 12),
        reason: "Inventory unavailable"
    )) {
        try await courier.run(in: session.context)
    }
    #expect(await session.operations.isEmpty)
}

@Test func checksIdsAndTypesInBothBranchesBeforePlay() {
    #expect(throws: ScriptDiagnostic(
        location: .init(path: courierPath, line: 13, column: 48),
        reason: "Unknown item ID .parcle"
    )) {
        try compileCourier(replacing: ".parcel", with: ".parcle")
    }
    #expect(throws: ScriptDiagnostic(
        location: .init(path: courierPath, line: 15, column: 12),
        reason: "Expected String, got Int"
    )) {
        try compileCourier(replacing: #""Тогда заберёте посылку на почте.""#, with: "42")
    }
}

private func compile(_ source: String) throws -> EncounterScript {
    try EncounterScript.compile(source, at: .init(path: "script.yaml", line: 1, column: 1), itemIDs: items)
}

@Test func choiceReturnsSelectedFloat() async throws {
    var registry = ExpressionRegistry<EncounterContext>()
    try registry.registerChoices()
    let script = try registry.compile(
        #"(chooseOne (case "quarter" 0.25) (case "half" 0.5))"#,
        returning: Float.self,
        at: ScriptLocation(path: "script.yaml", line: 1, column: 1)
    )
    let session = EncounterTestSession(coins: 0, answer: 1)
    #expect(try await script.run(in: session.context) == 0.5)
}

@Test(arguments: [
    #"(do (hasItem .coin) (say "next"))"#,
    #"(chooseOne (case "yes" (addItem .parcel)) (case "no" (hasItem .coin)))"#,
    #"(chooseOne (caseIf "yes" (removeItem .coin) (addItem .parcel)))"#,
    #"(chooseOne (case true (addItem .parcel)))"#,
    "(addItem .coin count: 1.5)",
    "(chooseOne)", "(addItem .coin count: 0)", "(addItem .coin count: 1 count: 2)",
    "(addItem .coin in: .missing)", "(addItem .coin count: 1 .parcel)",
    "(addItem .coin hnt: 2)", "(addItem .coin) (do)", "(do", #"(say "unterminated)"#,
    #"(say "bad\tescape")"#, "(do ; comment\n)", "(addItem .bad--id)", "(unknown .coin)"
])
func rejectsInvalidEncounterScripts(_ source: String) {
    #expect(throws: ScriptDiagnostic.self) { try compile(source) }
}

@Test(arguments: [
    ("removeItem", "Cannot remove items from all inventories at once."),
    ("addItem", "Cannot add items to all inventories at once.")
])
func suggestsOneInventoryForItemChanges(_ command: String, _ reason: String) throws {
    let origin = ScriptLocation(path: "events/trade.yaml", line: 10, column: 3)
    let location = ScriptLocation(path: origin.path, line: 11, column: 6)
    func compileChange(_ arguments: String) throws -> EncounterScript {
        try EncounterScript.compile(
            "(do\n  (\(command) \(arguments)))",
            at: origin,
            items: ["coin": .character, "hope": .party],
            characterIDs: ["anna"]
        )
    }

    #expect(throws: ScriptDiagnostic(
        location: location, reason: "\(reason) Choose one inventory with 'in: current' or a character ID such as 'in: .anna'."
    )) {
        try compileChange(".coin in: all")
    }
    _ = try compileChange(".coin in: current")
    _ = try compileChange(".coin in: .anna")

    #expect(throws: ScriptDiagnostic(location: location, reason: "\(reason) Omit 'in: all' to use the party inventory.")) {
        try compileChange(".hope in: all")
    }
    #expect(throws: ScriptDiagnostic(location: location, reason: "Party item .hope cannot have a character recipient")) {
        try compileChange(".hope in: .anna")
    }
    _ = try compileChange(".hope")
}

@Test func choiceEvaluatesTitlesAndConditionsBeforeSelection() async throws {
    let script = try compile("""
        (chooseOne
          (caseIf "Pay" (do (removeItem .coin) (hasItem .coin atLeast: 5)) (addItem .parcel))
          (case (do (say "At the station") "Leave") (say "Goodbye")))
        """)
    let session = EncounterTestSession(coins: 5, answer: 1)
    try await script.run(in: session.context)
    let choices = await session.choices
    #expect(choices.map(\.title) == ["Pay", "Leave"])
    #expect(choices.map(\.isAvailable) == [false, true])
    #expect(await session.operations == ["-1 coin"])
    #expect(await session.messages == ["At the station", "Goodbye"])
}

@Test func choiceCanReturnAValueAndNamedArgumentsCanBeReordered() async throws {
    let script = try compile("""
        (if (chooseOne
              (caseIf "yes" (hasItem .coin hint: "hint" atLeast: 5) true)
              (case "no" false))
            (addItem .parcel)
            (say "refused"))
        """)
    let session = EncounterTestSession(coins: 5, answer: 0)
    try await script.run(in: session.context)
    #expect(await session.operations == ["+1 parcel"])
}

@Test func noAvailableChoiceReportsTheChooseOnePosition() async throws {
    let script = try compile(#"(chooseOne (caseIf "pay" (hasItem .coin) (removeItem .coin)))"#)
    let session = EncounterTestSession(coins: 0, answer: 0)
    await #expect(throws: ScriptDiagnostic(
        location: .init(path: "script.yaml", line: 1, column: 2),
        reason: "No choices available"
    )) {
        try await script.run(in: session.context)
    }
    #expect(await session.choices.isEmpty)
}

@Test func computedItemCountsAllowZeroAndLocateNegativeResults() async throws {
    let session = EncounterTestSession(coins: 5, answer: 0)
    let zero = try compile("(removeItem .coin count: (if true 0 1))")
    try await zero.run(in: session.context)
    let negative = try compile("(removeItem .coin count: (if true -1 1))")
    await #expect(throws: ScriptDiagnostic(
        location: .init(path: "script.yaml", line: 1, column: 26),
        reason: "Item count cannot be negative"
    )) {
        try await negative.run(in: session.context)
    }
    #expect(await session.operations.isEmpty)
}
