import Scripting

struct HasItem: Expression {
    static let name = "hasItem"

    let item: ItemReference
    let target: InventoryTarget
    let atLeast: AnyExpression<Int, EncounterContext>
    let hint: AnyExpression<String, EncounterContext>?

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        item = try parser.nextArgument().asExpression(ItemReference.self)
        target = try parser.namedArgument("in")?.asExpression(InventoryTarget.self) ?? item.defaultTarget
        atLeast = try parser.namedArgument("atLeast")?.asAnyExpression(Int.self) ?? .constant(1)
        hint = try parser.namedArgument("hint")?.asAnyExpression(String.self)
        try item.check(target)
    }

    func run(in context: EncounterContext) async throws -> Bool {
        let minimum = try await atLeast.run(in: context)
        return try await context.inventory.itemCount(item.id, in: target) >= minimum
    }

    func disabledHint(in context: EncounterContext) async throws -> String? {
        let minimum = try await atLeast.run(in: context)
        guard try await context.inventory.itemCount(item.id, in: target) < minimum else {
            return nil
        }
        return try await hint?.run(in: context) ?? "Requires \(minimum) × .\(item.id)"
    }
}
