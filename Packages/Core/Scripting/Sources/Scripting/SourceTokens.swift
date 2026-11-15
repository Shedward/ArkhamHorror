// Group boundaries allow each command to inspect its immediate arguments, in any
// named-argument order. Nested forms are built directly as typed expressions.
struct SourceTokens {
    let tokens: [ScriptToken]
    private let closing: [Int: Int]

    init(_ text: String, origin: ScriptLocation) throws {
        var lexer = ScriptLexer(text, origin: origin)
        var tokens: [ScriptToken] = []
        var openings: [Int] = []
        var closing: [Int: Int] = [:]
        while true {
            let token = try lexer.next()
            let i = tokens.count
            tokens.append(token)
            switch token.kind {
            case .open:
                guard openings.count < 32 else { throw token.location.error("Maximum expression nesting exceeded") }
                openings.append(i)
            case .close:
                guard let start = openings.popLast() else { throw token.location.error("Unexpected closing parenthesis") }
                closing[start] = i
            case .end:
                if let start = openings.last { throw tokens[start].location.error("Unclosed parenthesis") }
                self.tokens = tokens
                self.closing = closing
                return
            default: break
            }
        }
    }

    func end(of index: Int) -> Int { (closing[index] ?? index) + 1 }
}
