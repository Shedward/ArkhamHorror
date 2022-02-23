//
//  SScannerTests.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import XCTest
@testable import Script

final class SScannerTests: XCTestCase {
	func testParsing() throws {
		let string = "(print \"Hello world\" 5 hello)"
		let scanner = SScanner(string: string)

		try scanner.openExpression()
		let methodName = try scanner.scanSymbol()
		try scanner.skipSeparator()
		let stringParam = try scanner.scanString()
		try? scanner.skipSeparator()
		let intParam = try scanner.scanInt()
		try scanner.skipSeparator()
		let symbolParam = try scanner.scanSymbol()

		XCTAssertEqual(methodName, "print")
		XCTAssertEqual(stringParam, "Hello world")
		XCTAssertEqual(intParam, 5)
		XCTAssertEqual(symbolParam, "hello")
	}
}
