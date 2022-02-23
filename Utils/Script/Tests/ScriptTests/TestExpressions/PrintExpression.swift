//
//  PrintExpression.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Script

struct Print: Expression {
	private let message: AnyExpression<LogContext, String>

	init(message: String) {
		self.message = Just(message).asAny()
	}

	init(message: AnyExpression<LogContext, String>) {
		self.message = message
	}

	func resolve(in context: LogContext) async {
		let message = await self.message.resolve(in: context)
		context.log(message)
	}
}

struct PrintParser: ExpressionParser {
	let head = "print"
	let doc = ExpressionDoc(
		signature: "(print \"message\")",
		description: "Print message to log context",
		example: "(print \"Hello world\")"
	)

	func parse(_ reader: ExpressionParameterReader<LogContext>) throws -> AnyExpression<LogContext, Void> {
		let messageExpression: AnyExpression<LogContext, String>

		if let message = try? reader.readString() {
			messageExpression = Just(message).asAny()
		} else {
			messageExpression = try reader.readExpression(String.self)
		}
		return Print(message: messageExpression).asAny()
	}
}
