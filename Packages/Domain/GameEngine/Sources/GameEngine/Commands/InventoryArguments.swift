import Scripting

enum ItemIDValidatorKey: MetadataKey { typealias Value = ItemValidator }
enum CharacterIDsKey: MetadataKey { typealias Value = Set<String> }

struct ItemValidator {
    let items: [String: ItemOwner]

    func owner(of id: String) throws -> ItemOwner {
        guard let owner = items[id] else { throw ScriptError("Unknown item ID .\(id)") }
        return owner
    }
}

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

struct ItemQuantity: Parsable {
    static var one: Self { Self(expression: .constant(1)) }

    let expression: AnyExpression<Int, EncounterContext>

    private init(expression: AnyExpression<Int, EncounterContext>) {
        self.expression = expression
    }

    init(argument: ParsableArgument<EncounterContext>) throws {
        if let count = try? argument.asInt(), count <= 0 {
            throw ScriptError("The 'count:' literal must be greater than zero")
        }
        expression = try argument.asAnyExpression(Int.self).validating { count in
            guard count >= 0 else { throw ScriptError("Item count cannot be negative") }
        }
    }
}
