import Scripting

struct ChoiceAvailability: Sendable {
    let enabled: Bool
    let hint: String?
}

struct HasItemAvailability: Expression {
    static let name = HasItem.name

    let check: HasItem

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        check = try HasItem(&parser)
    }

    func run(in context: EncounterContext) async throws -> ChoiceAvailability {
        let hint = try await check.disabledHint(in: context)
        return ChoiceAvailability(enabled: hint == nil, hint: hint)
    }
}
