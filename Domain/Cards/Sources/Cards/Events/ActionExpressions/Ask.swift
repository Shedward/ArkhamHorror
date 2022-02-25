//
//  Ask.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Script
import Prelude

struct Ask: Expression {
	let title: String

	func resolve(in context: EventContext) async -> Bool {
		let question = UserQuestion<Bool>(
			title: title,
			answers: [
				.init(title: Localized.string("Да"), value: true),
				.init(title: Localized.string("Нет"), value: false)
			]
		)
		return await context.askUser(question)
	}
}

struct AskParser: ExpressionParser {
	let head = "ask"
	let doc = ExpressionDoc(
		signature: #"(ask "question"):Bool"#,
		description: "Ask user question with ",
		example: #"(if (ask "Continue?") (continue) (doNothing))"#
	)

	func parse(_ reader: ExpressionParameterReader<EventContext>) throws -> AnyExpression<EventContext, Bool> {
		let question = try reader.readString()
		return Ask(title: question).asAny()
	}
}
