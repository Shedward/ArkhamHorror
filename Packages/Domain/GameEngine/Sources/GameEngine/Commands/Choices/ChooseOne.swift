import Scripting

private struct ChooseOne<Output: Sendable>: Expression {
    static var name: String {
        "chooseOne"
    }

    static var isMutating: Bool {
        true
    }

    let answers: [AnyExpression<ChoiceAnswer<Output>, EncounterContext>]

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        var answers = [try parser.nextArgument().asAnyExpression(ChoiceAnswer<Output>.self)]
        while let argument = try? parser.nextArgument() {
            answers.append(try argument.asAnyExpression(ChoiceAnswer<Output>.self))
        }
        self.answers = answers
    }

    func run(in context: EncounterContext) async throws -> Output {
        var options: [ChoiceAnswer<Output>] = []
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

extension ExpressionRegistry where Context == EncounterContext {
    mutating func registerChoices() throws {
        try register(HasItemAvailability.self)
        try registerChoices(returning: Void.self)
        try registerChoices(returning: Bool.self)
        try registerChoices(returning: Int.self)
        try registerChoices(returning: Float.self)
        try registerChoices(returning: String.self)
    }

    private mutating func registerChoices<T: Sendable>(returning: T.Type) throws {
        try register(Case<T>.self)
        try register(CaseIf<T>.self)
        try register(ChooseOne<T>.self)
    }
}
