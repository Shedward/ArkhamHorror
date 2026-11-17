import Scripting

struct CaseIf<Output: Sendable>: Expression {
    static var name: String {
        "caseIf"
    }

    let title: AnyExpression<String, EncounterContext>
    let availability: @Sendable (EncounterContext) async throws -> ChoiceAvailability
    let body: AnyExpression<Output, EncounterContext>

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        title = try parser.nextArgument().asAnyExpression(String.self)
        let condition = try parser.nextArgument()
        if condition.name == HasItem.name {
            availability = try condition.asAnyExpression(ChoiceAvailability.self).run
        } else {
            let check = try condition.asAnyExpression(Bool.self)
            availability = { context in
                try await ChoiceAvailability(enabled: check.run(in: context), hint: nil)
            }
        }
        body = try parser.nextArgument().asAnyExpression(Output.self)
    }

    func run(in context: EncounterContext) async throws -> ChoiceAnswer<Output> {
        let text = try await title.run(in: context)
        let state = try await availability(context)
        return ChoiceAnswer(choice: EncounterChoice(title: text, isAvailable: state.enabled, hint: state.hint), body: body)
    }
}
