@testable import Scripting
import Testing

private actor Counter: ScriptContext {
    private(set) var value = 0

    func increment() {
        value += 1
    }
}

private struct Tick: Expression {
    static let name = "tick"
    static let isMutating = true

    init(_ parser: inout ExpressionParser<Counter>) {
    }

    func run(in context: Counter) async {
        await context.increment()
    }
}

private let origin = ScriptLocation(path: "example.yaml", line: 2, column: 3)

@Test func readOnlyCompilationChecksEveryNestedBranchBeforeExecution() async throws {
    var registry = ExpressionRegistry<Counter>()
    try registry.register(Tick.self)
    let readOnly = registry.restrictingToReadOnly()
    let pure = try readOnly.compile("(if false 1 (do 2))", returning: Int.self, at: origin)
    #expect(try await pure.run(in: Counter()) == 2)
    #expect(throws: ScriptDiagnostic(
        location: ScriptLocation(path: origin.path, line: 3, column: 6),
        reason: "Command 'tick' is unavailable in a read-only expression"
    )) {
        try readOnly.compile("(if true 1 (do\n  (tick) 2))", returning: Int.self, at: origin)
    }
}

@Test func builtinsPropagateTheExpectedTypeAndRunOnlyTheSelectedBranch() async throws {
    var registry = ExpressionRegistry<Counter>()
    try registry.register(Tick.self)
    let script = try registry.compile("(do (tick) (if true 7 (do (tick) 9)))", returning: Int.self, at: origin)
    let counter = Counter()
    #expect(try await script.run(in: counter) == 7)
    #expect(await counter.value == 1)
    #expect(throws: ScriptError.self) { try registry.register(Tick.self) }
}

@Test(arguments: ["(do)", "(do 1 2)", "(if true 1 false)", "(if true 1)", "(do 1) (do 2)"])
func rejectsInvalidControlFlow(_ source: String) {
    #expect(throws: ScriptDiagnostic.self) {
        _ = try ExpressionRegistry<Counter>().compile(source, returning: Int.self, at: origin)
    }
}

@Test func reportsAnEmptyVoidBlockAtTheMissingArgument() {
    do {
        _ = try ExpressionRegistry<Counter>().compile("(do)", returning: Void.self, at: origin)
        Issue.record("Expected an empty block to fail")
    } catch let diagnostic as ScriptDiagnostic {
        #expect(diagnostic.reason == "'do' requires at least one argument")
        #expect(diagnostic.location == ScriptLocation(path: "example.yaml", line: 2, column: 6))
    } catch { Issue.record("Unexpected error: \(error)") }
}

@Test func readsEscapedTextAndRejectsExcessiveNesting() async throws {
    let registry = ExpressionRegistry<Counter>()
    let script = try registry.compile(#"(do "«Цена»\n\"5\"\\")"#, returning: String.self, at: origin)
    #expect(try await script.run(in: Counter()) == "«Цена»\n\"5\"\\")
    let deep = String(repeating: "(do ", count: 33) + "1" + String(repeating: ")", count: 33)
    #expect(throws: ScriptDiagnostic.self) { _ = try registry.compile(deep, returning: Int.self, at: origin) }
}
