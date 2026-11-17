import Scripting

public typealias EncounterScript = Script<Void, EncounterContext>

extension Script where Output == Void, Context == EncounterContext {
    public static func compile(
        _ source: String,
        at origin: ScriptLocation,
        items: [String: ItemOwner],
        characterIDs: Set<String> = []
    ) throws -> Self {
        var commands = ExpressionRegistry<EncounterContext>()
        try commands.register(HasItem.self, readOnly: true)
        try commands.register(AddItem.self)
        try commands.register(RemoveItem.self)
        try commands.register(Say.self)
        try commands.registerChoices()

        var metadata = ParserMetadata()
        metadata[ItemIDValidatorKey.self] = ItemValidator(items: items)
        metadata[CharacterIDsKey.self] = characterIDs
        return try commands.compile(source, returning: Void.self, metadata: metadata, at: origin)
    }

    /// Convenience for encounters using only personal items.
    public static func compile(_ source: String, at origin: ScriptLocation, itemIDs: Set<String>) throws -> Self {
        try compile(source, at: origin, items: Dictionary(uniqueKeysWithValues: itemIDs.map { ($0, .character) }))
    }
}
