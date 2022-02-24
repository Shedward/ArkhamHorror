//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Script

struct CheckLogLength: Expression {
	let expectedLogLength: Int

	func resolve(in context: LogContext) async -> Bool {
		context.logs.count >= expectedLogLength
	}
}

struct CheckLogLengthParser: ExpressionParser {
	let head = "checkLogLength"
	let doc = ExpressionDoc(
		signature: "(checkLogLength minLength:Int): Bool",
		description: "Returns true if current log length is equal or bigger than minLength",
		example: "(checkLogLength 3)"
	)

	func parse(_ reader: ExpressionParameterReader<LogContext>) throws -> AnyExpression<LogContext, Bool> {
		let expectedLogLength = try reader.readInt()
		return CheckLogLength(expectedLogLength: expectedLogLength).asAny()
	}
}
