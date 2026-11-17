public struct ScriptDiagnostic: Error, Equatable, CustomStringConvertible {
    public let location: ScriptLocation
    public let reason: String

    public var description: String {
        "\(location.path):\(location.line):\(location.column) — \(reason)"
    }

    public init(location: ScriptLocation, reason: String) {
        self.location = location
        self.reason = reason
    }
}
