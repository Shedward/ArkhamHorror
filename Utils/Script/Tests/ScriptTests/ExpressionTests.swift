//
//  ExpressionTests.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import XCTest
import Script

class TestContext {
	var logs: [String] = []

	func log(_ message: String) {
		logs.append(message)
	}
}

struct LogMessage: Expression {
	let message: String

	func resolve(in context: TestContext) async {
		context.log(message)
	}
}

struct CheckLogLength: Expression {
	let expectedLength: Int

	func resolve(in context: TestContext) async -> Bool {
		context.logs.count >= expectedLength
	}
}

class ExpressionTests: XCTestCase {
    func testExample() async {
		let expression = Do(
			LogMessage(message: "Hello world").asAny(),
			LogMessage(message: "Another message").asAny(),
			If(
				CheckLogLength(expectedLength: 2).asAny(),
				onSuccess: LogMessage(message: "Is at least 2 lines").asAny(),
				onFailure: LogMessage(message: "Is less than 2 lines").asAny()
			).asAny()
		)

		let context = TestContext()
		await expression.resolve(in: context)
		XCTAssertEqual(context.logs, ["Hello world", "Another message", "Is at least 2 lines"])
    }
}
