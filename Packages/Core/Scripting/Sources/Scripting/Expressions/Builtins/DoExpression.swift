public struct DoExpression<Output: Sendable, Context: ScriptContext>: Expression {
    public static var name: String {
        "do"
    }

    private var steps: [AnyExpression<Void, Context>] = []
    private let last: AnyExpression<Output, Context>

    public init(_ parser: inout ExpressionParser<Context>) throws {
        var pending = try parser.nextArgument()
        while let next = try? parser.nextArgument() {
            steps.append(try pending.asAnyExpression(Void.self))
            pending = next
        }
        last = try pending.asAnyExpression(Output.self)
    }

    public func run(in context: Context) async throws -> Output {
        for step in steps { try await step.run(in: context) }
        return try await last.run(in: context)
    }
}
