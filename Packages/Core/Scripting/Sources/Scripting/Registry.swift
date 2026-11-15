public struct ExpressionRegistry<C: ScriptContext> {
    private struct Entry {
        let model: ObjectIdentifier
        let readOnly: Bool
        let build: (ParsableArgument<C>) throws -> Any
    }
    private var entries: [String: [ObjectIdentifier: Entry]] = [:]
    private var requiresReadOnly = false

    public init() {
        installControlFlow(Void.self)
        installControlFlow(Bool.self)
        installControlFlow(Int.self)
        installControlFlow(String.self)
    }

    private mutating func installControlFlow<T: Sendable>(_ output: T.Type) {
        install(Do<T, C>.self, readOnly: true)
        install(If<T, C>.self, readOnly: true)
    }

    public mutating func register<E: Expression>(_ type: E.Type, readOnly: Bool = false) throws where E.Context == C {
        guard entries[E.name]?[ObjectIdentifier(E.Output.self)] == nil else {
            throw ScriptError("Duplicate registration for '\(E.name)' returning \(E.Output.self)")
        }
        install(type, readOnly: readOnly)
    }

    private mutating func install<E: Expression>(_ type: E.Type, readOnly: Bool) where E.Context == C {
        entries[E.name, default: [:]][ObjectIdentifier(E.Output.self)] = Entry(model: ObjectIdentifier(type), readOnly: readOnly) { arg in
            let node = try arg.asExpression(type)
            let location = arg.commandLocation
            return AnyExpression<E.Output, C>(location: arg.location) { context in
                do { return try await node.run(in: context) }
                catch { throw location.wrap(error) }
            }
        }
    }

    func restrictingToReadOnly() -> Self {
        var restricted = self
        restricted.requiresReadOnly = true
        return restricted
    }

    public func compile<T: Sendable>(_ text: String, returning: T.Type, metadata: ParserMetadata = .init(),
                                     at origin: ScriptLocation) throws -> Script<T, C> {
        let source = try SourceTokens(text, origin: origin)
        guard source.tokens[0].kind == .open else {
            throw source.tokens[0].location.error("Expected a parenthesized root expression")
        }
        let end = source.end(of: 0)
        guard source.tokens[end].kind == .end else {
            throw source.tokens[end].location.error("Unexpected input after the root expression")
        }
        let root = ParsableArgument(source: source, index: 0, registry: self, metadata: metadata)
        return try Script(root: root.asAnyExpression(T.self))
    }

    func supports<E: Expression>(_ type: E.Type) -> Bool where E.Context == C {
        guard let entry = entries[E.name]?[ObjectIdentifier(E.Output.self)] else { return false }
        return entry.model == ObjectIdentifier(type) && (!requiresReadOnly || entry.readOnly)
    }

    func build<T: Sendable>(_ name: String, returning: T.Type, argument: ParsableArgument<C>) throws
        -> AnyExpression<T, C> {
        guard let forms = entries[name] else {
            throw argument.commandLocation.error("Unknown command '\(name)'")
        }
        guard let entry = forms[ObjectIdentifier(T.self)] else {
            throw argument.commandLocation.error("'\(name)' cannot return \(T.self)")
        }
        guard !requiresReadOnly || entry.readOnly else {
            throw argument.commandLocation.error("Command '\(name)' is unavailable in a read-only expression")
        }
        let node = try entry.build(argument)
        guard let typed = node as? AnyExpression<T, C> else {
            preconditionFailure("The registered factory must produce its declared output type")
        }
        return typed
    }
}
