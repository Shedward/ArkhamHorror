import Scripting

struct RemoveItem: Expression {
    static let name = "removeItem"

    let change: ItemChange

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        change = try ItemChange(&parser, allInventoriesError: "Cannot remove items from all inventories at once.")
    }

    func run(in context: EncounterContext) async throws {
        let count = try await change.count.expression.run(in: context)
        if count > 0 { try await context.inventory.removeItem(change.item.id, count: count, in: change.target) }
    }
}
