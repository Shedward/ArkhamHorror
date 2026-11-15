/// A one-based Unicode scalar position in a campaign source file.
public struct ScriptLocation: Equatable, Sendable {
    public let path: String
    public let line: Int
    public let column: Int

    public init(path: String, line: Int, column: Int) {
        self.path = path
        self.line = line
        self.column = column
    }
}

public struct ScriptDiagnostic: Error, Equatable, CustomStringConvertible {
    public let location: ScriptLocation
    public let reason: String

    public init(location: ScriptLocation, reason: String) {
        self.location = location
        self.reason = reason
    }

    public var description: String {
        "\(location.path):\(location.line):\(location.column) — \(reason)"
    }
}
