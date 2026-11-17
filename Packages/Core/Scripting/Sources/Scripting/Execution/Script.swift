public struct Script<Output: Sendable, Context: ScriptContext>: Sendable {
    let root: AnyExpression<Output, Context>

    public func run(in context: Context) async throws -> Output {
        try await root.run(in: context)
    }
}
