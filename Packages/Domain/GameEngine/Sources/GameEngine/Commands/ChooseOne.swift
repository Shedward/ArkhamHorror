import Scripting

private struct Availability: Sendable {
    let enabled: Bool
    let hint: String?
}

private struct Answer<Output: Sendable>: Sendable {
    let choice: EncounterChoice
    let body: AnyExpression<Output, EncounterContext>
}

private struct Case<Output: Sendable>: Expression {
    static var name: String { "case" }
    let title: AnyExpression<String, EncounterContext>
    let body: AnyExpression<Output, EncounterContext>

    init(_ p: inout ExpressionParser<EncounterContext>) throws {
        title = try p.nextArgument().readOnly.asAnyExpression(String.self)
        body = try p.nextArgument().asAnyExpression(Output.self)
    }

    func run(in context: EncounterContext) async throws -> Answer<Output> {
        let text = try await title.run(in: context)
        return Answer(choice: EncounterChoice(title: text, isAvailable: true, hint: nil), body: body)
    }
}

/// In a choice, the same inventory check also supplies the reason a choice is disabled.
private struct HasItemAvailability: Expression {
    static let name = HasItem.name
    let check: HasItem

    init(_ p: inout ExpressionParser<EncounterContext>) throws { check = try HasItem(&p) }

    func run(in context: EncounterContext) async throws -> Availability {
        let hint = try await check.disabledHint(in: context)
        return Availability(enabled: hint == nil, hint: hint)
    }
}

private struct CaseIf<Output: Sendable>: Expression {
    static var name: String { "caseIf" }
    let title: AnyExpression<String, EncounterContext>
    let availability: @Sendable (EncounterContext) async throws -> Availability
    let body: AnyExpression<Output, EncounterContext>

    init(_ p: inout ExpressionParser<EncounterContext>) throws {
        title = try p.nextArgument().readOnly.asAnyExpression(String.self)
        let condition = try p.nextArgument().readOnly
        if condition.name == HasItem.name {
            availability = try condition.asAnyExpression(Availability.self).run
        } else {
            let check = try condition.asAnyExpression(Bool.self)
            availability = { context in
                try await Availability(enabled: check.run(in: context), hint: nil)
            }
        }
        body = try p.nextArgument().asAnyExpression(Output.self)
    }

    func run(in context: EncounterContext) async throws -> Answer<Output> {
        let text = try await title.run(in: context)
        let state = try await availability(context)
        return Answer(choice: EncounterChoice(title: text, isAvailable: state.enabled, hint: state.hint), body: body)
    }
}

private struct ChooseOne<Output: Sendable>: Expression {
    static var name: String { "chooseOne" }
    let answers: [AnyExpression<Answer<Output>, EncounterContext>]

    init(_ p: inout ExpressionParser<EncounterContext>) throws {
        var answers = [try p.nextArgument().asAnyExpression(Answer<Output>.self)]
        while let argument = try? p.nextArgument() {
            answers.append(try argument.asAnyExpression(Answer<Output>.self))
        }
        self.answers = answers
    }

    func run(in context: EncounterContext) async throws -> Output {
        var options: [Answer<Output>] = []
        for answer in answers { options.append(try await answer.run(in: context)) }
        let choices = options.map(\.choice)
        guard choices.contains(where: \.isAvailable) else { throw ScriptError("No choices available") }
        let index = try await context.choose(choices)
        guard options.indices.contains(index), choices[index].isAvailable else {
            throw ScriptError("Invalid or unavailable choice at index \(index)")
        }
        return try await options[index].body.run(in: context)
    }
}

extension ExpressionRegistry where C == EncounterContext {
    mutating func registerChoices() throws {
        try register(HasItemAvailability.self, readOnly: true)
        try registerChoices(returning: Void.self)
        try registerChoices(returning: Bool.self)
        try registerChoices(returning: Int.self)
        try registerChoices(returning: String.self)
    }

    private mutating func registerChoices<T: Sendable>(returning: T.Type) throws {
        try register(Case<T>.self)
        try register(CaseIf<T>.self)
        try register(ChooseOne<T>.self)
    }
}
