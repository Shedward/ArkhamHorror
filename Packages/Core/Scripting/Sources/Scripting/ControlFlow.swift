public struct Do<Output: Sendable, C: ScriptContext>: Expression {
    public static var name: String { "do" }
    private var steps: [AnyExpression<Void, C>] = []
    private let last: AnyExpression<Output, C>

    public init(_ p: inout ExpressionParser<C>) throws {
        var pending = try p.nextArgument()
        while let next = try? p.nextArgument() {
            steps.append(try pending.asAnyExpression(Void.self))
            pending = next
        }
        last = try pending.asAnyExpression(Output.self)
    }

    public func run(in context: C) async throws -> Output {
        for step in steps { try await step.run(in: context) }
        return try await last.run(in: context)
    }
}

public struct If<Output: Sendable, C: ScriptContext>: Expression {
    public static var name: String { "if" }
    private let condition: AnyExpression<Bool, C>
    private let yes: AnyExpression<Output, C>
    private let no: AnyExpression<Output, C>

    public init(_ p: inout ExpressionParser<C>) throws {
        condition = try p.nextArgument().asAnyExpression(Bool.self)
        yes = try p.nextArgument().asAnyExpression(Output.self)
        no = try p.nextArgument().asAnyExpression(Output.self)
    }

    public func run(in context: C) async throws -> Output {
        if try await condition.run(in: context) { return try await yes.run(in: context) }
        return try await no.run(in: context)
    }
}
