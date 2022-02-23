//
//  ExpressionParser.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct ExpressionDoc {
	public let signature: String
	public let description: String?
	public let example: String?

	public init(signature: String, description: String? = nil, example: String? = nil) {
		self.signature = signature
		self.description = description
		self.example = example
	}
}

public protocol DocumentedExpressionParser {
	var doc: ExpressionDoc { get }
}

public protocol ExpressionParser: DocumentedExpressionParser {
	associatedtype Context
	associatedtype Result

	var head: String { get }

	func parse(_ reader: ExpressionParameterReader<Context>) throws -> AnyExpression<Context, Result>
}

public struct AnyExpressionParser<Context, Result>: ExpressionParser {
	public let head: String
	public let doc: ExpressionDoc

	private let parseAction: (ExpressionParameterReader<Context>) throws -> AnyExpression<Context, Result>

	public init<Wrapped: ExpressionParser>(_ wrapped: Wrapped) where Wrapped.Context == Context, Wrapped.Result == Result {
		head = wrapped.head
		doc = wrapped.doc
		parseAction = wrapped.parse(_:)
	}

	public func parse(_ reader: ExpressionParameterReader<Context>) throws -> AnyExpression<Context, Result> {
		try parseAction(reader)
	}
}

extension ExpressionParser {
	func asAny() -> AnyExpressionParser<Context, Result> {
		AnyExpressionParser(self)
	}
}
