//
//  ExpressionParameterReader.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct ExpressionParameterReader<Context> {
	private let tokenReader: TokenReader
	private let expressionRepository: ExpressionParsersRepository<Context>

	public var currentIndex: String.Index {
		tokenReader.currentIndex
	}

	init(tokenReader: TokenReader, expressionRepository: ExpressionParsersRepository<Context>) {
		self.tokenReader = tokenReader
		self.expressionRepository = expressionRepository
	}

	public func readInt() throws -> Int {
		let int = try tokenReader.readInt()
		try? tokenReader.skipSeparator()
		return int
	}

	public func readString() throws -> String {
		let string = try tokenReader.readString()
		try? tokenReader.skipSeparator()
		return string
	}

	public func readSymbol() throws -> String {
		let symbol = try tokenReader.readSymbol()
		try? tokenReader.skipSeparator()
		return symbol
	}

	public func readRaw<T: RawRepresentable>(
		_ type: T.Type
	) throws -> T where T.RawValue == String {
		let symbol = try readSymbol()
		guard let value = T(rawValue: symbol) else {
			throw SemanticError(message: "Value '\(symbol)' can not be represented as \(T.self)", position: tokenReader.currentIndex)
		}

		return value
	}

	public func readExpression<Result>(_ resultType: Result.Type) throws -> AnyExpression<Context, Result> {
		let expressionReader = ExpressionReader<Context, Result>(
			tokenReader: tokenReader,
			expressionParserRepository: expressionRepository
		 )

		let expression = try expressionReader.readExpression()
		try? tokenReader.skipSeparator()
		return expression
	}

	public func readExpression() throws -> AnyExpression<Context, Void> {
		try readExpression(Void.self)
	}

	public func haveParameter() -> Bool {
		!tokenReader.willCloseExpression()
	}
}


