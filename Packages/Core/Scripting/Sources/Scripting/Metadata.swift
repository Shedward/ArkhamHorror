public protocol MetadataKey {
    associatedtype Value
}

public struct ParserMetadata {
    private var values: [ObjectIdentifier: Any] = [:]
    public init() {}

    public subscript<K: MetadataKey>(_ key: K.Type) -> K.Value? {
        get { values[ObjectIdentifier(key)] as? K.Value }
        set { values[ObjectIdentifier(key)] = newValue }
    }
}
