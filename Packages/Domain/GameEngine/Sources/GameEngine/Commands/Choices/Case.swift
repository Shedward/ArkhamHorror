import Scripting

struct Case<Output: Sendable>: Expression {
    static var name: String {
        "case"
    }

    let title: AnyExpression<String, EncounterContext>
    let body: AnyExpression<Output, EncounterContext>

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        title = try parser.nextArgument().asAnyExpression(String.self)
        body = try parser.nextArgument().asAnyExpression(Output.self)
    }

    func run(in context: EncounterContext) async throws -> ChoiceAnswer<Output> {
        let text = try await title.run(in: context)
        return ChoiceAnswer(choice: EncounterChoice(title: text, isAvailable: true, hint: nil), body: body)
    }
}
