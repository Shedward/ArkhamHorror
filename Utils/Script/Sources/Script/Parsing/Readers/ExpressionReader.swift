//
//  ExpressionReader.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

struct ExpressionReader<Context, Result> {
	private let tokenReader: TokenReader
	private let expressionParserRepository: ExpressionParsersRepository<Context>

	init(tokenReader: TokenReader, expressionParserRepository: ExpressionParsersRepository<Context>) {
		self.tokenReader = tokenReader
		self.expressionParserRepository = expressionParserRepository
	}

	func readExpression() throws -> AnyExpression<Context, Result> {
		try tokenReader.openExpression()
		let head = try tokenReader.readSymbol()
		try? tokenReader.skipSeparator()
		guard let parser = expressionParserRepository.parser(head: head, returnType: Result.self) else {
			let possibleSymbolsList = expressionParserRepository.documentationSuggestion(for: head)
				.map { $0.signature }
				.joined(separator: "\n")
			throw TypeError(
				message: """
				Symbol \(head) for return type \(Result.self) not found.
				---
				Possible symbols:
				\(possibleSymbolsList)
				"""
			)
		}
		let parametersReader = ExpressionParameterReader(tokenReader: tokenReader, expressionRepository: expressionParserRepository)
		let expression = try parser.parse(parametersReader)
		try tokenReader.closeExpression()
		return expression
	}
}
