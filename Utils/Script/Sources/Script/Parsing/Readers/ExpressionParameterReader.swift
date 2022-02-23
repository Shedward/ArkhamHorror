//
//  ExpressionParameterReader.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct ExpressionParameterReader<Context> {
	private let tokenReader: TokenReader

	public var currentIndex: String.Index {
		tokenReader.currentIndex
	}

	init(tokenReader: TokenReader) {
		self.tokenReader = tokenReader
	}

	public func readInt() throws -> Int {
		try tokenReader.readInt()
	}

	public func readString() throws -> String {
		try tokenReader.readString()
	}

	public func readSymbol() throws -> String {
		try tokenReader.readSymbol()
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
		fatalError()
	}

	public func readExpression() throws -> AnyExpression<Context, Void> {
		try readExpression(Void.self)
	}

	public func haveParameter() -> Bool {
		fatalError()
	}
}


