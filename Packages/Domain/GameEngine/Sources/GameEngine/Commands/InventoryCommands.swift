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

/// Both inventory updates accept the same arguments and write to one inventory.
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

struct AddItem: Expression {
    static let name = "addItem"
    let change: ItemChange

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        change = try ItemChange(&parser)
    }

    func run(in context: EncounterContext) async throws {
        let count = try await change.count.expression.run(in: context)
        if count > 0 { try await context.inventory.addItem(change.item.id, count: count, in: change.target) }
    }
}

struct RemoveItem: Expression {
    static let name = "removeItem"
    let change: ItemChange

    init(_ parser: inout ExpressionParser<EncounterContext>) throws {
        change = try ItemChange(&parser)
    }

    func run(in context: EncounterContext) async throws {
        let count = try await change.count.expression.run(in: context)
        if count > 0 { try await context.inventory.removeItem(change.item.id, count: count, in: change.target) }
    }
}
