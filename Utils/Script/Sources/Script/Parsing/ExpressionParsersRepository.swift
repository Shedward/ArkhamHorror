//
//  ExpressionParsersRepository.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct ExpressionParsersRepository<Context> {
	private struct ParserDescriptor: Hashable {
		let head: String
		let returnType: String

		init<T>(head: String, returnType: T.Type) {
			self.head = head
			self.returnType = String(describing: returnType)
		}
	}

	private var parsers: [ParserDescriptor: Any] = [:]

	public init() {
	}

	mutating public func register<Parser: ExpressionParser>(_ parser: Parser) throws where Parser.Context == Context {
		let descriptor = ParserDescriptor(head: parser.head, returnType: Parser.Result.self)

		if let existingParser = parsers[descriptor] {
			throw TypeError(message: "Parser \(Parser.self) tried to replace \(existingParser) for \(descriptor)")
		}

		parsers[descriptor] = parser.asAny()
	}

	mutating public func unregister<Result>(head: String, returnType: Result.Type) {
		let descriptor = ParserDescriptor(head: head, returnType: returnType)
		parsers.removeValue(forKey: descriptor)
	}

	public func parser<Result>(head: String, returnType: Result.Type) -> AnyExpressionParser<Context, Result>? {
		let descriptor = ParserDescriptor(head: head, returnType: returnType)
		return parsers[descriptor] as? AnyExpressionParser<Context, Result>
	}

	public func documentationSuggestion(for headPrefix: String) -> [ExpressionDoc] {
		parsers
			.filter { $0.key.head.starts(with: headPrefix) }
			.compactMap { ($0.value as? DocumentedExpressionParser)?.doc }
	}
}
