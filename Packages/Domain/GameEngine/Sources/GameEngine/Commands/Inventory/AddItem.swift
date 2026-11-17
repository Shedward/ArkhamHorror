import Scripting

struct AddItem: Expression {
    static let name = "addItem"

    let change: ItemChange

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        change = try ItemChange(&parser, allInventoriesError: "Cannot add items to all inventories at once.")
    }

    func run(in context: EncounterContext) async throws {
        let count = try await change.count.expression.run(in: context)
        if count > 0 { try await context.inventory.addItem(change.item.id, count: count, in: change.target) }
    }
}
