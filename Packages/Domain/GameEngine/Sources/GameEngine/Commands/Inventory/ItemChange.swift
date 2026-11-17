import Scripting

struct ItemChange {
    let item: ItemReference
    let target: InventoryTarget
    let count: ItemQuantity

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        item = try parser.nextArgument().asExpression(ItemReference.self)
        target = try parser.namedArgument("in")?.asExpression(InventoryTarget.self) ?? item.defaultTarget
        count = try parser.namedArgument("count")?.asExpression(ItemQuantity.self) ?? .one
        guard target != .all else { throw ScriptError("'in: all' is read-only") }
        try item.check(target)
    }
}
