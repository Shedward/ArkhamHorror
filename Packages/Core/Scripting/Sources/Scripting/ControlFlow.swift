public struct DoExpression<Output: Sendable, Context: ScriptContext>: Expression {
    public static var name: String { "do" }
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

public struct IfExpression<Output: Sendable, Context: ScriptContext>: Expression {
    public static var name: String { "if" }
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
