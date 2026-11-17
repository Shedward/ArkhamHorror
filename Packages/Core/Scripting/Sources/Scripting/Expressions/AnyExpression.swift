public struct AnyExpression<Output: Sendable, Context: ScriptContext>: Sendable {
    public static func constant(_ value: Output) -> Self {
        Self { _ in value }
    }

    var location: ScriptLocation?
    let evaluate: @Sendable (Context) async throws -> Output

    public func run(in context: Context) async throws -> Output {
        try await evaluate(context)
    }

    public func validating(_ check: @escaping @Sendable (Output) throws -> Void) -> Self {
        Self(location: location) { context in
            let value = try await run(in: context)
            do {
                try check(value)
            } catch {
                throw location?.wrap(error) ?? error
            }
            return value
        }
    }
}
