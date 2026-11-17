import Scripting

struct Say: Expression {
    static let name = "say"
    let text: AnyExpression<String, EncounterContext>

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        text = try parser.nextArgument().asAnyExpression(String.self)
    }

    func run(in context: EncounterContext) async throws {
        try await context.say(text.run(in: context))
    }
}
