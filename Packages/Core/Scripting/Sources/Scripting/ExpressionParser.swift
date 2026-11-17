public struct EndOfArguments: Error {
    let diagnostic: ScriptDiagnostic
}

public struct ExpressionParser<Context: ScriptContext> {
    public let metadata: ParserMetadata
    private let missing: EndOfArguments
    private var positional: ArraySlice<ParsableArgument<Context>> = []
    private var named: [String: (label: ScriptLocation, value: ParsableArgument<Context>)] = [:]

    init(call: ParsableArgument<Context>) throws {
        metadata = call.metadata
        let source = call.source
        let end = source.end(of: call.index) - 1
        guard case let .name(name) = source.tokens[call.index + 1].kind else {
            throw call.location.error("Expected a command name")
        }
        var i = call.index + 2
        while i < end {
            if case let .label(key) = source.tokens[i].kind {
                let label = source.tokens[i].location
                guard named[key] == nil else { throw label.error("Duplicate argument '\(key):'") }
                i += 1
                guard i < end else { throw label.error("Missing value for '\(key):'") }
                if case .label = source.tokens[i].kind { throw source.tokens[i].location.error("Expected an argument value") }
                named[key] = (label, call.child(at: i))
            } else {
                guard named.isEmpty else { throw source.tokens[i].location.error("Positional argument after a named argument") }
                positional.append(call.child(at: i))
            }
            i = source.end(of: i)
        }
        let reason = positional.isEmpty ? "'\(name)' requires at least one argument" : "Missing positional argument for '\(name)'"
        missing = EndOfArguments(diagnostic: source.tokens[end].location.error(reason))
    }

    public mutating func nextArgument() throws(EndOfArguments) -> ParsableArgument<Context> {
        guard let arg = positional.popFirst() else { throw missing }
        return arg
    }

    public mutating func namedArgument(_ key: String) -> ParsableArgument<Context>? {
        named.removeValue(forKey: key)?.value
    }

    func finish() throws {
        if let extra = positional.first { throw extra.location.error("Unexpected positional argument") }
        if let (key, arg) = named.min(by: { $0.value.value.index < $1.value.value.index }) {
            throw arg.label.error("Unknown argument '\(key):'")
        }
    }
}
