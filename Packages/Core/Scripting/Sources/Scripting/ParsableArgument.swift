public struct ParsableArgument<C: ScriptContext> {
    let source: SourceTokens
    let index: Int
    let registry: ExpressionRegistry<C>
    public let metadata: ParserMetadata
    var location: ScriptLocation { source.tokens[index].location }
    var commandLocation: ScriptLocation { source.tokens[index + 1].location }

    public var name: String? {
        guard case .open = source.tokens[index].kind, case let .name(name) = source.tokens[index + 1].kind else {
            return nil
        }
        return name
    }

    /// Restricts this argument and its entire subtree to read-only commands.
    public var readOnly: Self {
        Self(source: source, index: index, registry: registry.restrictingToReadOnly(), metadata: metadata)
    }

    public func asId() throws -> String {
        guard case let .id(id) = source.tokens[index].kind else { throw location.error("Expected a dot-prefixed ID") }
        return id
    }

    public func asBool() throws -> Bool {
        switch source.tokens[index].kind {
        case .name("true"): return true
        case .name("false"): return false
        default: throw location.error("Expected a Bool literal")
        }
    }

    public func asInt() throws -> Int {
        guard case let .integer(n) = source.tokens[index].kind else { throw location.error("Expected an Int literal") }
        return n
    }

    public func asFloat() throws -> Float {
        guard let value = Float(exactly: try asInt()) else { throw location.error("Integer cannot be represented exactly as Float") }
        return value
    }

    public func asString() throws -> String {
        guard case let .text(text) = source.tokens[index].kind else { throw location.error("Expected a string literal") }
        return text
    }

    public func asSymbol() throws -> String {
        guard case let .name(name) = source.tokens[index].kind, name != "true", name != "false" else {
            throw location.error("Expected a symbol")
        }
        return name
    }

    public func asExpression<T: Parsable>(_ type: T.Type = T.self) throws -> T where T.Context == C {
        do { return try T(argument: self) }
        catch { throw location.wrap(error) }
    }

    public func asExpression<E: Expression>(_ type: E.Type) throws -> E where E.Context == C {
        guard case .open = source.tokens[index].kind,
              source.tokens[index + 1].kind == .name(E.name) else {
            throw location.error("Expected an expression headed by '\(E.name)'")
        }
        guard registry.supports(type) else { throw location.error("'\(E.name)' is unavailable in this context") }
        do {
            var parser = try ExpressionParser(call: self)
            let node = try E(&parser)
            try parser.finish()
            return node
        } catch { throw commandLocation.wrap(error) }
    }

    public func asAnyExpression<T: Sendable>(_ type: T.Type) throws -> AnyExpression<T, C> {
        switch source.tokens[index].kind {
        case .open:
            guard case let .name(name) = source.tokens[index + 1].kind else {
                throw source.tokens[index + 1].location.error("Expected a command name")
            }
            return try registry.build(name, returning: type, argument: self)
        case .integer: return try literal(asInt(), as: type)
        case .text: return try literal(asString(), as: type)
        case .name("true"), .name("false"): return try literal(asBool(), as: type)
        default: throw location.error("Expected an expression returning \(T.self)")
        }
    }

    private func literal<Value, T: Sendable>(_ value: Value, as: T.Type) throws -> AnyExpression<T, C> {
        guard ObjectIdentifier(Value.self) == ObjectIdentifier(T.self), let result = value as? T else {
            throw location.error("Expected \(T.self), got \(Value.self)")
        }
        return AnyExpression(location: location) { _ in result }
    }

    func child(at index: Int) -> Self {
        Self(source: source, index: index, registry: registry, metadata: metadata)
    }
}
