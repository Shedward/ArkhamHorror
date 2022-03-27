//
//  SScannerTests.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import XCTest
@testable import Script

final class TokenReaderTests: XCTestCase {
	func testParsing() throws {
		let string = "(print \"Hello world\" 5 hello)"
		let reader = TokenReader(string: string)

		try reader.openExpression()
		let methodName = try reader.readSymbol()
		reader.skipSeparator()
		let stringParam = try reader.readString()
		reader.skipSeparator()
		let intParam = try reader.readInt()
		reader.skipSeparator()
		let symbolParam = try reader.readSymbol()
		try reader.closeExpression()

		XCTAssertEqual(methodName, "print")
		XCTAssertEqual(stringParam, "Hello world")
		XCTAssertEqual(intParam, 5)
		XCTAssertEqual(symbolParam, "hello")
	}
}
