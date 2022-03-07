//
//  ChooseOne.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Script
import Prelude

struct ChooseOne<Result>: Expression {
	struct Choice {
		let title: String
		let expression: AnyExpression<Context, Result>
	}

	let choices: [Choice]

	func resolve(in context: EventContext) async -> Result {
		let question = UserQuestion<Int>(
			title: nil,
			answers: choices.indices.map { index in
				UserQuestion.Answer(title: choices[index].title, value: index)
			}
		)
		let chosenIndex = await context.askUser(question)
		let result = await choices[chosenIndex].expression.resolve(in: context)
		return result
	}
}

struct ChooseOneParser<Result>: ExpressionParser {
	let head = "chooseOne"
	let doc = ExpressionDoc(
		signature: #"(chooseOne "oneChoice" (oneAction):Some "twoChoice" (twoAction):Some ...):Some"#,
		description: "Shows user dialog with N choices, when user pick one - nth expression executed.",
		example: #"(chooseOne "Take 2 damage" (takeDamage 2) "Became delayed" (becameDelayed))"#
	)

	func parse(_ reader: ExpressionParameterReader<EventContext>) throws -> AnyExpression<EventContext, Result> {
		var choices: [ChooseOne<Result>.Choice] = []

		while reader.haveAnotherParameter() {
			let title = try reader.readString()
			let expression = try reader.readExpression(Result.self)

			choices.append(.init(title: title, expression: expression))
		}

		return ChooseOne(choices: choices).asAny()
	}
}
