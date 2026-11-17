import Scripting

struct ItemReference: Parsable {
    let id: String
    let defaultTarget: InventoryTarget

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
