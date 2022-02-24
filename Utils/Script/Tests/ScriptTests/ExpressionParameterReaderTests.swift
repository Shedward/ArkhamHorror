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
		XCTAssertThrowsError(try paramReader.readSymbol())
	}

	func testWordReading() throws {
		let paramReader = try createParametersReader(for: "param1 \"param2\" 3 enum4")
		let symbol1 = try paramReader.readSymbol()
		let string2 = try paramReader.readString()
		let int3 = try paramReader.readInt()
		let enum4 = try paramReader.readRaw(TestEnum.self)

		XCTAssertEqual(symbol1, "param1")
		XCTAssertEqual(string2, "param2")
		XCTAssertEqual(int3, 3)
		XCTAssertEqual(enum4, .enum4)
	}

	private func createParametersReader(for string: String) throws -> ExpressionParameterReader<LogContext> {
		let tokenReader = TokenReader(string: string)
		let repository = try TestExpressionRepository.create()
		return ExpressionParameterReader(tokenReader: tokenReader, expressionRepository: repository)
	}
}
