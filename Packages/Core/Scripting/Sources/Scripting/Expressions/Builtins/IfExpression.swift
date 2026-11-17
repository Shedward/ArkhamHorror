public struct IfExpression<Output: Sendable, Context: ScriptContext>: Expression {
    public static var name: String {
        "if"
    }

    private let condition: AnyExpression<Bool, Context>
    private let thenBranch: AnyExpression<Output, Context>
    private let elseBranch: AnyExpression<Output, Context>

    public init(_ parser: inout ExpressionParser<Context>) throws {
        condition = try parser.nextArgument().asAnyExpression(Bool.self)
        thenBranch = try parser.nextArgument().asAnyExpression(Output.self)
        elseBranch = try parser.nextArgument().asAnyExpression(Output.self)
    }

    public func run(in context: Context) async throws -> Output {
        if try await condition.run(in: context) {
            return try await thenBranch.run(in: context)
        }
        return try await elseBranch.run(in: context)
    }
}
