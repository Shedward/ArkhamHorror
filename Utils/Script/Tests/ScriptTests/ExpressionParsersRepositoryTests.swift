//
//  ExpressionParsersRepository.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import XCTest
@testable import Script

final class ExpressionParsersRepositoryTests: XCTestCase {
	private func createRepository() throws -> ExpressionParsersRepository<LogContext> {
		var parsersRepository = ExpressionParsersRepository<LogContext>()
		try parsersRepository.register(DoParser())
		try parsersRepository.register(IfParser<LogContext, Void>())
		try parsersRepository.register(DoNothingParser())
		try parsersRepository.register(PrintParser())
		try parsersRepository.register(ConcatParser())
		try parsersRepository.register(CheckLogLengthParser())
		return parsersRepository
	}

	func testRegistration() throws {
		let repository = try createRepository()
		let doParser = repository.parser(head: "do", returnType: Void.self)
		XCTAssertNotNil(doParser)

		let notExisting = repository.parser(head: "notExisting", returnType: Void.self)
		XCTAssertNil(notExisting)
	}

	func testDoubleRegistration() throws {
		var repository = try createRepository()
		XCTAssertThrowsError(try repository.register(DoParser()))
	}

	func testUnregistering() throws {
		var repository = try createRepository()
		repository.unregister(head: "do", returnType: Void.self)
		let doParser = repository.parser(head: "do", returnType: Void.self)
		XCTAssertNil(doParser)
	}

	func testPolymorphismByReturnType() throws {
		var repository = ExpressionParsersRepository<LogContext>()
		try repository.register(IfParser<LogContext, Void>())
		try repository.register(IfParser<LogContext, String>())

		let voidIf = repository.parser(head: "if", returnType: Void.self)
		XCTAssertNotNil(voidIf)

		let stringIf = repository.parser(head: "if", returnType: String.self)
		XCTAssertNotNil(stringIf)
	}
}
