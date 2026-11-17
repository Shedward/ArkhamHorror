import Scripting

enum ItemIDValidatorKey: MetadataKey { typealias Value = ItemValidator }

struct ItemValidator {
    let items: [String: ItemOwner]

    func owner(of id: String) throws -> ItemOwner {
        guard let owner = items[id] else { throw ScriptError("Unknown item ID .\(id)") }
        return owner
    }
}
