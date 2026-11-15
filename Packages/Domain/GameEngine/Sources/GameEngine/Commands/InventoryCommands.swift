import Scripting

struct HasItem: Expression {
    static let name = "hasItem"
    let item: ItemReference
    let target: InventoryTarget
    let atLeast: AnyExpression<Int, EncounterContext>
    let hint: AnyExpression<String, EncounterContext>?

    init(_ p: inout ExpressionParser<EncounterContext>) throws {
        item = try p.nextArgument().asExpression(ItemReference.self)
        target = try p.namedArgument("in")?.asExpression(InventoryTarget.self) ?? item.defaultTarget
        atLeast = try p.namedArgument("atLeast")?.asAnyExpression(Int.self) ?? .constant(1)
        hint = try p.namedArgument("hint")?.asAnyExpression(String.self)
        try item.check(target)
    }

    func run(in context: EncounterContext) async throws -> Bool {
        let minimum = try await atLeast.run(in: context)
        return try await context.inventory.itemCount(item.id, in: target) >= minimum
    }

    func disabledHint(in context: EncounterContext) async throws -> String? {
        let minimum = try await atLeast.run(in: context)
        guard try await context.inventory.itemCount(item.id, in: target) < minimum else { return nil }
        return try await hint?.run(in: context) ?? "Requires \(minimum) × .\(item.id)"
    }
}

/// Both inventory updates accept the same arguments and write to one inventory.
struct ItemChange {
    let item: ItemReference
    let target: InventoryTarget
    let count: ItemQuantity

    init(_ p: inout ExpressionParser<EncounterContext>) throws {
        item = try p.nextArgument().asExpression(ItemReference.self)
        target = try p.namedArgument("in")?.asExpression(InventoryTarget.self) ?? item.defaultTarget
        count = try p.namedArgument("count")?.asExpression(ItemQuantity.self) ?? .one
        guard target != .all else { throw ScriptError("'in: all' is read-only") }
        try item.check(target)
    }
}

struct AddItem: Expression {
    static let name = "addItem"
    let change: ItemChange

    init(_ p: inout ExpressionParser<EncounterContext>) throws { change = try ItemChange(&p) }

    func run(in context: EncounterContext) async throws {
        let n = try await change.count.expression.run(in: context)
        if n > 0 { try await context.inventory.addItem(change.item.id, count: n, in: change.target) }
    }
}

struct RemoveItem: Expression {
    static let name = "removeItem"
    let change: ItemChange

    init(_ p: inout ExpressionParser<EncounterContext>) throws { change = try ItemChange(&p) }

    func run(in context: EncounterContext) async throws {
        let n = try await change.count.expression.run(in: context)
        if n > 0 { try await context.inventory.removeItem(change.item.id, count: n, in: change.target) }
    }
}
