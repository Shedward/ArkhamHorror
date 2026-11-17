public protocol Parsable: Sendable {
    associatedtype Context: ScriptContext
    init(argument: ParsableArgument<Context>) throws
}
