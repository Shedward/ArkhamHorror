@testable import Scripting
import Testing

private struct LexemeContext: ScriptContext {}

private let origin = ScriptLocation(path: "events/example.yaml", line: 8, column: 3)

private func literal(_ text: String) throws -> ParsableArgument<LexemeContext> {
    let source = try SourceTokens(text, origin: origin)
    try #require(source.tokens.count == 2 && source.tokens[1].kind == .end)
    return ParsableArgument(source: source, index: 0, registry: .init(), metadata: .init())
}

@Test(arguments: ["influence", "a", "Action2", "True", "false2"])
func parsesCaseSensitiveSymbols(_ symbol: String) throws {
    let argument = try literal(symbol)
    #expect(try argument.asSymbol() == symbol)
    #expect(throws: ScriptDiagnostic.self) { try argument.asBool() }
    #expect(throws: ScriptDiagnostic.self) { try argument.asId() }
}

@Test(arguments: [("true", true), ("false", false)])
func parsesReservedBooleanLiterals(_ text: String, expected: Bool) throws {
    let argument = try literal(text)
    #expect(try argument.asBool() == expected)
    #expect(throws: ScriptDiagnostic.self) { try argument.asSymbol() }

    let quoted = try literal("\"\(text)\"")
    #expect(try quoted.asString() == text)
    #expect(throws: ScriptDiagnostic.self) { try quoted.asBool() }

    let reference = try literal(".\(text)")
    #expect(try reference.asId() == text)
    #expect(throws: ScriptDiagnostic.self) { try reference.asBool() }
}

@Test(arguments: [("0", 0), ("1", 1), ("42", 42), ("-2", -2)])
func parsesDecimalIntegers(_ text: String, expected: Int) throws {
    #expect(try literal(text).asInt() == expected)
}

@Test(arguments: [("0.25", Float(0.25)), ("-1.5", -1.5), ("2.0", 2), ("0.0", 0)])
func parsesFloatLiterals(_ text: String, expected: Float) async throws {
    let argument = try literal(text)
    #expect(try argument.asFloat() == expected)
    #expect(throws: ScriptDiagnostic.self) { try argument.asInt() }

    let registry = ExpressionRegistry<LexemeContext>()
    let script = try registry.compile("(do (if true \(text) 0.5))", returning: Float.self, at: origin)
    #expect(try await script.run(in: LexemeContext()) == expected)
}

@Test func readsExactlyRepresentableIntegersAsFloat() throws {
    #expect(try literal("42").asFloat() == 42)
    #expect(throws: ScriptDiagnostic(location: origin, reason: "Integer cannot be represented exactly as Float")) {
        try literal("16777217").asFloat()
    }
}

@Test func locatesOutOfRangeFloat() {
    let text = String(repeating: "9", count: 40) + ".0"
    #expect(throws: ScriptDiagnostic(location: origin, reason: "Float literal is out of range")) {
        try literal(text)
    }
}

@Test(arguments: [".a", ".parcel", ".collect-parcel", ".platform-2", ".a2-3b-c4"])
func parsesDotPrefixedCampaignIDs(_ text: String) throws {
    let argument = try literal(text)
    #expect(try argument.asId() == String(text.dropFirst()))
    #expect(throws: ScriptDiagnostic.self) { try argument.asSymbol() }
}

@Test(arguments: [
    (#""""#, ""),
    (#""Поезд «Север» 🚂; (этап: 2)""#, "Поезд «Север» 🚂; (этап: 2)"),
    (#""\"""#, "\""),
    (#""\\""#, "\\"),
    (#""\n""#, "\n")
])
func decodesStringLiterals(_ text: String, expected: String) throws {
    #expect(try literal(text).asString() == expected)
}

@Test(arguments: ["\n", "\r\n", "\r"])
func separatesNestedFormsAndLabels(_ newline: String) throws {
    let source = " (placeEvent .courier\(newline)\tposition: top forQuest2: (currentQuest)) "
    let tokens = try SourceTokens(source, origin: origin).tokens
    try #require(tokens.map(\.kind) == [
        .open, .name("placeEvent"), .id("courier"),
        .label("position"), .name("top"), .label("forQuest2"), .open, .name("currentQuest"), .close, .close, .end
    ])
    #expect(tokens[3].location == ScriptLocation(path: origin.path, line: 9, column: 4))
}

@Test(arguments: [
    "_", "имя", "2name", "some-name", "some_name",
    ".", ".2train", ".Train", ".поезд", ".-post", ".post-", ".post--office", ".post_office",
    "-", "1.", ".5", "1.2.3", "1e2", "1_000", ";"
])
func rejectsInvalidAtomsAtTheirStart(_ atom: String) {
    #expect(throws: ScriptDiagnostic(
        location: ScriptLocation(path: origin.path, line: 9, column: 5),
        reason: "Invalid token '\(atom)'"
    )) {
        try SourceTokens("(do\n  \(atom))", origin: origin)
    }
}

@Test(arguments: [
    ("hint : 1", 8, "Invalid token ':'"),
    (#""🚂\t""#, 5, "Unknown escape sequence"),
    (#""unfinished"#, 3, "Unterminated string literal"),
    ("\"first\nsecond\"", 3, "Unterminated string literal")
])
func locatesMalformedLabelsAndStrings(_ text: String, column: Int, reason: String) {
    #expect(throws: ScriptDiagnostic(
        location: ScriptLocation(path: origin.path, line: origin.line, column: column),
        reason: reason
    )) {
        try SourceTokens(text, origin: origin)
    }
}
