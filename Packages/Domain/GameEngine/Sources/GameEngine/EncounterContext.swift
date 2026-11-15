import Scripting

public enum ItemOwner: Sendable { case party, character }

public enum InventoryTarget: Equatable, Sendable {
    case party, current, character(String), all
}

public protocol EncounterInventory: Sendable {
    func itemCount(_ id: String, in target: InventoryTarget) async throws -> Int
    func addItem(_ id: String, count: Int, in target: InventoryTarget) async throws
    func removeItem(_ id: String, count: Int, in target: InventoryTarget) async throws
}

public struct EncounterChoice: Equatable, Sendable {
    public let title: String
    public let isAvailable: Bool
    public let hint: String?
}

public struct EncounterContext: ScriptContext {
    let inventory: any EncounterInventory
    let choose: @Sendable ([EncounterChoice]) async throws -> Int
    let say: @Sendable (String) async throws -> Void

    /// The chooser returns a zero-based index into the complete list, including disabled choices.
    public init(inventory: any EncounterInventory,
                choose: @escaping @Sendable ([EncounterChoice]) async throws -> Int,
                say: @escaping @Sendable (String) async throws -> Void) {
        self.inventory = inventory
        self.choose = choose
        self.say = say
    }
}
