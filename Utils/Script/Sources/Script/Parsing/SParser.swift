//
//  SParser.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct SParserDoc {
	public let signature: String
	public let description: String?
	public let example: String?

	public init(signature: String, description: String? = nil, example: String? = nil) {
		self.signature = signature
		self.description = description
		self.example = example
	}
}

public protocol SParser {
	associatedtype Context
	associatedtype Result

	var head: String { get }
	var doc: SParserDoc { get }
	func parse(_ reader: SReader<Context>) throws -> AnyExpression<Context, Result>
}
