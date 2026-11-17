public protocol Expression: Sendable {
    associatedtype Context: ScriptContext
    associatedtype Output: Sendable

    static var name: String { get }
    static var isMutating: Bool { get }

    init(_ parser: inout ExpressionParser<Context>) throws
    func run(in context: Context) async throws -> Output
}

extension Expression {
    public static var isMutating: Bool {
        false
    }
}
