//
//  TestExpressionRepository.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

import XCTest
@testable import Script

enum TestExpressionRepository {
	static func create() throws -> ExpressionParsersRepository<LogContext> {
		var parsersRepository = ExpressionParsersRepository<LogContext>()
		try parsersRepository.register(DoParser())
		try parsersRepository.register(IfParser<LogContext, Void>())
		try parsersRepository.register(DoNothingParser())
		try parsersRepository.register(PrintParser())
		try parsersRepository.register(ConcatParser())
		try parsersRepository.register(CheckLogLengthParser())
		return parsersRepository
	}

	static func createEmpty() -> ExpressionParsersRepository<LogContext> {
		ExpressionParsersRepository<LogContext>()
	}
}
