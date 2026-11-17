import Scripting

public struct EncounterContext: ScriptContext {
    let inventory: any EncounterInventory
    let choose: @Sendable ([EncounterChoice]) async throws -> Int
    let say: @Sendable (String) async throws -> Void

    public init(inventory: any EncounterInventory,
                choose: @escaping @Sendable ([EncounterChoice]) async throws -> Int,
                say: @escaping @Sendable (String) async throws -> Void) {
        self.inventory = inventory
        self.choose = choose
        self.say = say
    }
}
