import Scripting

struct Say: Expression {
    static let name = "say"
    let text: AnyExpression<String, EncounterContext>

    init(_ p: inout ExpressionParser<EncounterContext>) throws {
        text = try p.nextArgument().asAnyExpression(String.self)
    }

    func run(in context: EncounterContext) async throws {
        try await context.say(text.run(in: context))
    }
}
