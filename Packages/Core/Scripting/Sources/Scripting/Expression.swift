public protocol ScriptContext: Sendable {}

public protocol Parsable: Sendable {
    associatedtype Context: ScriptContext
    init(argument: ParsableArgument<Context>) throws
}

public protocol Expression: Sendable {
    associatedtype Context: ScriptContext
    associatedtype Output: Sendable
    static var name: String { get }
    init(_ parser: inout ExpressionParser<Context>) throws
    func run(in context: Context) async throws -> Output
}

public struct AnyExpression<Output: Sendable, C: ScriptContext>: Sendable {
    var location: ScriptLocation? = nil
    let evaluate: @Sendable (C) async throws -> Output

    public func run(in context: C) async throws -> Output {
        try await evaluate(context)
    }

    public static func constant(_ value: Output) -> Self { Self { _ in value } }

    public func validating(_ check: @escaping @Sendable (Output) throws -> Void) -> Self {
        Self(location: location) { context in
            let value = try await run(in: context)
            do { try check(value) }
            catch { throw location?.wrap(error) ?? error }
            return value
        }
    }
}

public struct Script<Output: Sendable, C: ScriptContext>: Sendable {
    let root: AnyExpression<Output, C>

    public func run(in context: C) async throws -> Output {
        try await root.run(in: context)
    }
}

public struct ScriptError: Error, CustomStringConvertible {
    public let description: String
    public init(_ description: String) { self.description = description }
}

extension ScriptLocation {
    func error(_ reason: String) -> ScriptDiagnostic {
        ScriptDiagnostic(location: self, reason: reason)
    }

    func wrap(_ error: Error) -> Error {
        if let end = error as? EndOfArguments { return end.diagnostic }
        if error is ScriptDiagnostic || error is CancellationError { return error }
        return self.error(String(describing: error))
    }
}
