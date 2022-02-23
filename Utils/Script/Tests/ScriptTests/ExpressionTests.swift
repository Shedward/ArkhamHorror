//
//  ExpressionTests.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import XCTest
import Script

class LoggingContext {
	var logs: [String] = []

	func log(_ message: String) {
		logs.append(message)
	}
}

struct Print: Expression {
	let message: String

	func resolve(in context: LoggingContext) async {
		context.log(message)
	}
}

struct IsLogLengthGreaterOrEqual: Expression {
	let expectedLength: Int

	func resolve(in context: LoggingContext) async -> Bool {
		context.logs.count >= expectedLength
	}
}

class ExpressionTests: XCTestCase {
    func testExample() async {
		let expression = Do(
			Print(message: "Hello world").asAny(),
			Print(message: "Another message").asAny(),
			If(
				IsLogLengthGreaterOrEqual(expectedLength: 2).asAny(),
				then: Print(message: "It's at least 2 lines").asAny(),
				else: Print(message: "It's less than 2 lines").asAny()
			).asAny()
		)

		let context = LoggingContext()
		await expression.resolve(in: context)
		XCTAssertEqual(context.logs, ["Hello world", "Another message", "It's at least 2 lines"])
    }
}
