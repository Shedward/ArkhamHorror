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
        try wrapParameterError(message: "Expected Int parameter.") {
            let int = try tokenReader.readInt()
            try? tokenReader.skipSeparator()
            return int
        }
	}

	public func readString() throws -> String {
        try wrapParameterError(message: "Expected String parameter.") {
            let string = try tokenReader.readString()
            try? tokenReader.skipSeparator()
            return string
        }
	}

	public func readSymbol() throws -> String {
        try wrapParameterError(message: "Expected Symbol.") {
            let symbol = try tokenReader.readSymbol()
            try? tokenReader.skipSeparator()
            return symbol
        }
	}

	public func readRaw<T: RawRepresentable>(
		_ type: T.Type
	) throws -> T where T.RawValue == String {
        try wrapParameterError(message: "Expected \(String(describing: type)) parameter.") {
            try? tokenReader.skipSeparator()
            let symbol = try readSymbol()
            guard let value = T(rawValue: symbol) else {
                throw SemanticError(
                    message: "Value '\(symbol)' can not be represented as \(T.self)",
                    context: tokenReader.currentContext
                )
            }
            try? tokenReader.skipSeparator()

            return value
        }
	}

	public func readExpression<Result>(_ resultType: Result.Type) throws -> AnyExpression<Context, Result> {
        try wrapParameterError(message: "Expected Expression returning \(String(describing: resultType)).") {
            let expressionReader = ExpressionReader<Context, Result>(
                tokenReader: tokenReader,
                expressionParserRepository: expressionRepository
            )

            let expression = try expressionReader.readExpression()
            try? tokenReader.skipSeparator()
            return expression
        }
	}

	public func readData<Parser: DataParser>(
		_ parser: Parser
	) throws -> Parser.Data where Parser.Context == Context {
       try wrapParameterError(
        message: "Expected data \(String(describing: Parser.Data.self)) using \(String(describing: Parser.self))."
       ) {
            return try tokenReader.safeRead { tokenReader in
                try? tokenReader.skipSeparator()
                try tokenReader.openExpression()
                let head = try tokenReader.readSymbol()
                try? tokenReader.skipSeparator()
                let parameterReader = ExpressionParameterReader(
                    tokenReader: tokenReader,
                    expressionRepository: expressionRepository
                )

                let data =  try parser.parse(head: head, parametersReader: parameterReader)
                try? tokenReader.skipSeparator()
                try tokenReader.closeExpression()
                try? tokenReader.skipSeparator()
                return data
            }
        }
	}

	public func readExpression() throws -> AnyExpression<Context, Void> {
		try readExpression(Void.self)
	}

	public func haveAnotherParameter() -> Bool {
		!tokenReader.willCloseExpression()
	}

	public func peekRest() -> String? {
		tokenReader.peekRest()
	}

    private func wrapParameterError<Return>(message: String, _ actions: () throws -> Return) throws -> Return {
        do {
            return try actions()
        } catch {
            throw ParameterError(
                message: message,
                underlyingError: error
            )
        }
    }
}


