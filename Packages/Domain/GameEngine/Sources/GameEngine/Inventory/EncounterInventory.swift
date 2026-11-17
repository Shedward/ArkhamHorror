public protocol EncounterInventory: Sendable {
    func itemCount(_ id: String, in target: InventoryTarget) async throws -> Int
    func addItem(_ id: String, count: Int, in target: InventoryTarget) async throws
    func removeItem(_ id: String, count: Int, in target: InventoryTarget) async throws
}
