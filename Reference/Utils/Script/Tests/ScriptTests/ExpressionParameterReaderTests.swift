//
//  ExpressionParameterReaderTests.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

import XCTest
@testable import Script

final class ExpressionParameterReaderTests: XCTestCase {
	enum TestEnum: String, Equatable {
		case enum1
		case enum2
		case enum3
		case enum4
	}

	func testEmpty() throws {
		let paramReader = try createParametersReader(for: "")
        XCTAssertThrowsError(try paramReader.readString())
	}

	func testWordReading() throws {
		let paramReader = try createParametersReader(for: "\"param1\" 2 enum3")
		let string1 = try paramReader.readString()
		let int2 = try paramReader.readInt()
		let enum3 = try paramReader.readRaw(TestEnum.self)

		XCTAssertEqual(string1, "param1")
		XCTAssertEqual(int2, 2)
		XCTAssertEqual(enum3, .enum3)
	}

	private func createParametersReader(for string: String) throws -> ExpressionParameterReader<LogContext> {
		let tokenReader = TokenReader(string: string)
		let repository = try TestExpressionRepository.create()
		return ExpressionParameterReader(tokenReader: tokenReader, expressionRepository: repository)
	}
}
