public struct ExpressionRegistry<Context: ScriptContext> {
    private var entries: [String: [ObjectIdentifier: Entry]] = [:]

    public init() {
        installControlFlow(Void.self)
        installControlFlow(Bool.self)
        installControlFlow(Int.self)
        installControlFlow(Float.self)
        installControlFlow(String.self)
    }

    private mutating func installControlFlow<T: Sendable>(_ output: T.Type) {
        install(DoExpression<T, Context>.self)
        install(IfExpression<T, Context>.self)
    }

    public mutating func register<Node: Expression>(_ type: Node.Type) throws where Node.Context == Context {
        guard entries[Node.name]?[ObjectIdentifier(Node.Output.self)] == nil else {
            throw ScriptError("Duplicate registration for '\(Node.name)' returning \(Node.Output.self)")
        }
        install(type)
    }

    private mutating func install<Node: Expression>(_ type: Node.Type) where Node.Context == Context {
        let entry = Entry(model: ObjectIdentifier(type)) { arg in
            let node = try arg.asExpression(type)
            let location = arg.commandLocation
            return AnyExpression<Node.Output, Context>(location: arg.location) { context in
                do {
                    return try await node.run(in: context)
                } catch {
                    throw location.wrap(error)
                }
            }
        }
        entries[Node.name, default: [:]][ObjectIdentifier(Node.Output.self)] = entry
    }

    public func compile<T: Sendable>(
        _ text: String,
        returning: T.Type,
        metadata: ParserMetadata = .init(),
        at origin: ScriptLocation
    ) throws -> Script<T, Context> {
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

    func supports<Node: Expression>(_ type: Node.Type) -> Bool where Node.Context == Context {
        entries[Node.name]?[ObjectIdentifier(Node.Output.self)]?.model == ObjectIdentifier(type)
    }

    func build<T: Sendable>(_ name: String, returning: T.Type, argument: ParsableArgument<Context>) throws
        -> AnyExpression<T, Context> {
        guard let forms = entries[name] else {
            throw argument.commandLocation.error("Unknown command '\(name)'")
        }
        guard let entry = forms[ObjectIdentifier(T.self)] else {
            throw argument.commandLocation.error("'\(name)' cannot return \(T.self)")
        }
        let node = try entry.build(argument)
        guard let typed = node as? AnyExpression<T, Context> else {
            preconditionFailure("The registered factory must produce its declared output type")
        }
        return typed
    }
}

extension ExpressionRegistry {
    private struct Entry {
        let model: ObjectIdentifier
        let build: (ParsableArgument<Context>) throws -> Any
    }
}
