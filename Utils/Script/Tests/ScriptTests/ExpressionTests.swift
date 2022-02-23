//
//  ExpressionTests.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import XCTest
import Script

final class ExpressionTests: XCTestCase {
    func testBasicExpression() async {
		let expression = Do(
			Print(message: "Hello world").asAny(),
			Print(message: "Another message").asAny(),
			If(
				CheckLogLength(expectedLogLength: 2).asAny(),
				then: Print(message: "It's at least 2 lines").asAny(),
				else: Print(message: "It's less than 2 lines").asAny()
			).asAny()
		)

		let context = LogContext()
		await expression.resolve(in: context)
		XCTAssertEqual(context.logs, ["Hello world", "Another message", "It's at least 2 lines"])
    }
}
