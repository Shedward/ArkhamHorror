struct ScriptToken {
    let kind: Kind
    let location: ScriptLocation
}

extension ScriptToken {
    enum Kind: Equatable {
        case open, close, end
        case name(String), label(String), id(String), text(String), integer(Int), float(Float)
    }
}
