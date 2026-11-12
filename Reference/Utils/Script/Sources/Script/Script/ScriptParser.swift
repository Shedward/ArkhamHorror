//
//  ScriptParser.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//


public struct ScriptParser<Context, Result> {
	private var expressionsRepository: ExpressionParsersRepository<Context>

	public init() {
		expressionsRepository = .init()
	}

	public init(expressionParsers: [AnyExpressionParser<Context, Result>]) throws {
		var expressionsRepository = ExpressionParsersRepository<Context>()
		try expressionParsers.forEach { parser in
			try expressionsRepository.register(parser)
		}
		self.expressionsRepository = expressionsRepository
	}

	mutating public func register<Parser: ExpressionParser>(
		_ parser: Parser
	) throws where Parser.Context == Context {
		try expressionsRepository.register(parser)
	}

	public func parse(string: String) throws -> Script<Context, Result> {
		let tokenReader = TokenReader(string: string)
		let expressionReader = ExpressionReader<Context, Result>(
			tokenReader: tokenReader,
			expressionParserRepository: expressionsRepository
		)
		let rootExpression = try expressionReader.readExpression()
		return Script(rootExpression: rootExpression)
	}
}
