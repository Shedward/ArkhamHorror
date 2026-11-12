//
//  ExpressionParserTests.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

import XCTest
@testable import Script

final class ExpressionParserTests: XCTestCase {
	func testExpressionParser() async throws {
		let string = #"(print (concat "Hello world" " + " "Oleg"))"#
		let tokenReader = TokenReader(string: string)
		let expressionReader = ExpressionReader<LogContext, Void>(
			tokenReader: tokenReader,
			expressionParserRepository: try TestExpressionRepository.create()
		)

		let rootExpression = try expressionReader.readExpression()

		let context = LogContext()
		await rootExpression.resolve(in: context)
		XCTAssertEqual(context.logs, ["Hello world + Oleg"])
	}
}
