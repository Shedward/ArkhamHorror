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

extension ScriptLocation {
    func error(_ reason: String) -> ScriptDiagnostic {
        ScriptDiagnostic(location: self, reason: reason)
    }

    func wrap(_ error: Error) -> Error {
        if let end = error as? EndOfArguments {
            return end.diagnostic
        }
        if error is ScriptDiagnostic || error is CancellationError {
            return error
        }
        return self.error(String(describing: error))
    }
}
