public struct ParsableArgument<Context: ScriptContext> {
    let source: SourceTokens
    let index: Int
    let registry: ExpressionRegistry<Context>
    public let metadata: ParserMetadata

    var location: ScriptLocation {
        source.tokens[index].location
    }

    var commandLocation: ScriptLocation {
        source.tokens[index + 1].location
    }

    public var name: String? {
        guard case .open = source.tokens[index].kind, case let .name(name) = source.tokens[index + 1].kind else {
            return nil
        }
        return name
    }

    public var readOnly: Self {
        Self(source: source, index: index, registry: registry.restrictingToReadOnly(), metadata: metadata)
    }

    public func asId() throws -> String {
        guard case let .id(id) = source.tokens[index].kind else { throw location.error("Expected a dot-prefixed ID") }
        return id
    }

    public func asBool() throws -> Bool {
        switch source.tokens[index].kind {
            case .name("true"):
                return true
            case .name("false"):
                return false
            default:
                throw location.error("Expected a Bool literal")
        }
    }

    public func asInt() throws -> Int {
        guard case let .integer(value) = source.tokens[index].kind else { throw location.error("Expected an Int literal") }
        return value
    }

    public func asFloat() throws -> Float {
        switch source.tokens[index].kind {
            case let .float(value):
                return value
            case let .integer(integer):
                guard let value = Float(exactly: integer) else {
                    throw location.error("Integer cannot be represented exactly as Float")
                }
                return value
            default:
                throw location.error("Expected a Float literal")
        }
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

    public func asExpression<T: Parsable>(_ type: T.Type = T.self) throws -> T where T.Context == Context {
        do {
            return try T(argument: self)
        } catch {
            throw location.wrap(error)
        }
    }

    public func asExpression<Node: Expression>(_ type: Node.Type) throws -> Node where Node.Context == Context {
        guard
            case .open = source.tokens[index].kind,
            source.tokens[index + 1].kind == .name(Node.name)
        else {
            throw location.error("Expected an expression headed by '\(Node.name)'")
        }
        guard registry.supports(type) else { throw location.error("'\(Node.name)' is unavailable in this context") }
        do {
            var parser = try ExpressionParser(call: self)
            let node = try Node(&parser)
            try parser.finish()
            return node
        } catch { throw commandLocation.wrap(error) }
    }

    public func asAnyExpression<T: Sendable>(_ type: T.Type) throws -> AnyExpression<T, Context> {
        switch source.tokens[index].kind {
            case .open:
                guard case let .name(name) = source.tokens[index + 1].kind else {
                    throw source.tokens[index + 1].location.error("Expected a command name")
                }
                return try registry.build(name, returning: type, argument: self)
            case .integer:
                return try literal(asInt(), as: type)
            case let .float(value):
                return try literal(value, as: type)
            case .text:
                return try literal(asString(), as: type)
            case .name("true"), .name("false"):
                return try literal(asBool(), as: type)
            default:
                throw location.error("Expected an expression returning \(T.self)")
        }
    }

    private func literal<Value, T: Sendable>(_ value: Value, as _: T.Type) throws -> AnyExpression<T, Context> {
        guard ObjectIdentifier(Value.self) == ObjectIdentifier(T.self), let result = value as? T else {
            throw location.error("Expected \(T.self), got \(Value.self)")
        }
        return AnyExpression(location: location) { _ in result }
    }

    func child(at index: Int) -> Self {
        Self(source: source, index: index, registry: registry, metadata: metadata)
    }
}
