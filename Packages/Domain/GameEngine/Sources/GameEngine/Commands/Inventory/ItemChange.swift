import Scripting

struct ItemChange {
    let item: ItemReference
    let target: InventoryTarget
    let count: ItemQuantity

    init(_ parser: inout ExpressionParser<EncounterContext>, allInventoriesError: String) throws {
        item = try parser.nextArgument().asExpression(ItemReference.self)
        target = try parser.namedArgument("in")?.asExpression(InventoryTarget.self) ?? item.defaultTarget
        count = try parser.namedArgument("count")?.asExpression(ItemQuantity.self) ?? .one
        guard target != .all else {
            let hint = item.defaultTarget == .party
                ? "Omit 'in: all' to use the party inventory."
                : "Choose one inventory with 'in: current' or a character ID such as 'in: .anna'."
            throw ScriptError("\(allInventoriesError) \(hint)")
        }
        try item.check(target)
    }
}
