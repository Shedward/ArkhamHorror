import Scripting

struct ItemReference: Parsable {
    let id: String
    let defaultTarget: InventoryTarget

    var singleInventoryHint: String {
        defaultTarget == .party
            ? "Omit 'in: all' to use the party inventory."
            : "Choose one inventory with 'in: current' or a character ID such as 'in: .anna'."
    }

    init(argument: ParsableArgument<EncounterContext>) throws {
        id = try argument.asId()
        let owner = try argument.metadata[ItemIDValidatorKey.self]?.owner(of: id)
        defaultTarget = owner == .party ? .party : .current
    }

    func check(_ target: InventoryTarget) throws {
        if defaultTarget == .party, target != .party {
            throw ScriptError("Party item .\(id) cannot have a character recipient")
        }
    }
}
