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
            tokenReader.skipSeparator()
            return int
        }
	}

    public func readOptionalInt() throws -> Int? {
        try readOptional {
            try readInt()
        }
    }

	public func readString() throws -> String {
        try wrapParameterError(message: "Expected String parameter.") {
            let string = try tokenReader.readString()
            tokenReader.skipSeparator()
            return string
        }
	}

    public func readOptionalString() throws -> String? {
        try readOptional {
            try readString()
        }
    }

	public func readRaw<T: RawRepresentable>(
		_ type: T.Type
	) throws -> T where T.RawValue == String {
        try wrapParameterError(message: "Expected \(String(describing: type)) parameter.") {
            tokenReader.skipSeparator()
            let symbol = try tokenReader.readSymbol()
            guard let value = T(rawValue: symbol) else {
                throw SemanticError(
                    message: "Value '\(symbol)' can not be represented as \(T.self)",
                    context: tokenReader.currentContext
                )
            }
            tokenReader.skipSeparator()

            return value
        }
	}

    public func readOptionalRaw<T: RawRepresentable>(
        _ type: T.Type
    ) throws -> T? where T.RawValue == String {
        try readOptional {
            try readRaw(T.self)
        }
    }

	public func readExpression<Result>(_ resultType: Result.Type) throws -> AnyExpression<Context, Result> {
        try wrapParameterError(message: "Expected Expression returning \(String(describing: resultType)).") {
            let expressionReader = ExpressionReader<Context, Result>(
                tokenReader: tokenReader,
                expressionParserRepository: expressionRepository
            )

            let expression = try expressionReader.readExpression()
            tokenReader.skipSeparator()
            return expression
        }
	}

    public func readOptionalExpression<Result>(
        _ resultType: Result.Type
    ) throws -> AnyExpression<Context, Result>? {
        try readOptional {
            try readExpression(Result.self)
        }
    }

	public func readData<Parser: DataParser>(
		_ parser: Parser
	) throws -> Parser.Data where Parser.Context == Context {
       try wrapParameterError(
        message: "Expected data \(String(describing: Parser.Data.self)) using \(String(describing: Parser.self))."
       ) {
            return try tokenReader.safeRead { tokenReader in
                tokenReader.skipSeparator()
                try tokenReader.openExpression()
                let head = try tokenReader.readSymbol()
                tokenReader.skipSeparator()
                let parameterReader = ExpressionParameterReader(
                    tokenReader: tokenReader,
                    expressionRepository: expressionRepository
                )

                let data =  try parser.parse(head: head, parametersReader: parameterReader)
                tokenReader.skipSeparator()
                try tokenReader.closeExpression()
                tokenReader.skipSeparator()
                return data
            }
        }
	}

    public func readOptionalData<Parser: DataParser>(
        _ parser: Parser
    ) throws -> Parser.Data? where Parser.Context == Context {
        try readOptional {
            try readData(parser)
        }
    }

	public func readExpression() throws -> AnyExpression<Context, Void> {
		try readExpression(Void.self)
	}

    public func readOptionalExpression() throws -> AnyExpression<Context, Void>? {
        try readOptionalExpression(Void.self)
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

    private func readOptional<Return>(_ readParameter: () throws -> Return) throws -> Return? {
        if haveAnotherParameter() {
            if tokenReader.readPlaceholder() {
                return nil
            } else {
                return try readParameter()
            }
        } else {
            return nil
        }
    }
}


