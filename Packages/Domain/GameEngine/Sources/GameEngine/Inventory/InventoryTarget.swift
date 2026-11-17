import Scripting

public enum InventoryTarget: Equatable, Sendable {
    case party, current, character(String), all
}

extension InventoryTarget: Parsable {
    public init(argument: ParsableArgument<EncounterContext>) throws {
        if let symbol = try? argument.asSymbol() {
            switch symbol {
                case "current":
                    self = .current
                case "all":
                    self = .all
                default:
                    throw ScriptError("Unknown inventory selector '\(symbol)'")
            }
        } else {
            let id = try argument.asId()
            if let ids = argument.metadata[CharacterIDsKey.self], !ids.contains(id) {
                throw ScriptError("Unknown character ID .\(id)")
            }
            self = .character(id)
        }
    }
}
