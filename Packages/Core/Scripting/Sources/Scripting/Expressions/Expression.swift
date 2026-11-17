public protocol Expression: Sendable {
    associatedtype Context: ScriptContext
    associatedtype Output: Sendable

    static var name: String { get }

    init(_ parser: inout ExpressionParser<Context>) throws
    func run(in context: Context) async throws -> Output
}
