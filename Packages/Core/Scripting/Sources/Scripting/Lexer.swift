struct ScriptToken {
    enum Kind: Equatable {
        case open, close, end
        case name(String), label(String), id(String), text(String), integer(Int)
    }
    let kind: Kind
    let location: ScriptLocation
}

struct ScriptLexer {
    private var input: Substring.UnicodeScalarView
    private let origin: ScriptLocation
    private var line: Int
    private var column: Int

    init(_ source: String, origin: ScriptLocation) {
        input = source[...].unicodeScalars
        self.origin = origin
        line = origin.line
        column = origin.column
    }

    private var location: ScriptLocation {
        .init(path: origin.path, line: line, column: column)
    }

    @discardableResult
    private mutating func advance() -> Unicode.Scalar? {
        guard let scalar = input.popFirst() else { return nil }
        if scalar == "\r" || scalar == "\n" {
            if scalar == "\r", input.first == "\n" { input.removeFirst() }
            line += 1
            column = origin.column
            return "\n"
        }
        column += 1
        return scalar
    }

    mutating func next() throws -> ScriptToken {
        while let c = input.first, Self.isSpace(c) { advance() }
        let start = location
        guard let c = input.first else { return ScriptToken(kind: .end, location: start) }
        let kind: ScriptToken.Kind
        switch c {
        case "(": advance(); kind = .open
        case ")": advance(); kind = .close
        case "\"": kind = try .text(readString(at: start))
        default: kind = try readAtom(at: start)
        }
        return ScriptToken(kind: kind, location: start)
    }

    private static func isSpace(_ c: Unicode.Scalar) -> Bool {
        c == " " || c == "\t" || c == "\n" || c == "\r"
    }

    private mutating func readAtom(at start: ScriptLocation) throws -> ScriptToken.Kind {
        var word = ""
        while let c = input.first, !Self.isSpace(c), c != "(", c != ")", c != "\"", c != ":" {
            word.unicodeScalars.append(c)
            advance()
        }
        if word.wholeMatch(of: /[A-Za-z][A-Za-z0-9]*/) != nil {
            if input.first == ":" { advance(); return .label(word) }
            return .name(word)
        }
        if word.wholeMatch(of: /\.[a-z][a-z0-9]*(?:-[a-z0-9]+)*/) != nil {
            return .id(String(word.dropFirst()))
        }
        if word.wholeMatch(of: /-?[0-9]+/) != nil, let value = Int(word) {
            return .integer(value)
        }
        throw ScriptDiagnostic(location: start, reason: "Invalid token '\(word.isEmpty ? ":" : word)'")
    }

    private mutating func readString(at start: ScriptLocation) throws -> String {
        advance()
        var result = ""
        while let c = input.first, c != "\n", c != "\r" {
            let position = location
            advance()
            switch c {
            case "\"": return result
            case "\\":
                switch advance() {
                case "\"": result.append("\"")
                case "\\": result.append("\\")
                case "n": result.append("\n")
                default: throw ScriptDiagnostic(location: position, reason: "Unknown escape sequence")
                }
            default: result.unicodeScalars.append(c)
            }
        }
        throw ScriptDiagnostic(location: start, reason: "Unterminated string literal")
    }
}
