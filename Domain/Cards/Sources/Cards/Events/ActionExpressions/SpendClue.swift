//
//  SpendClue.swift
//  
//
//  Created by Vladislav Maltsev on 26.02.2022.
//

import Script

struct SpendClue: Expression {
	let amount: Int

	func resolve(in context: EventContext) async -> Bool {
		guard context.user.cluesCount >= amount else {
			return false
		}

		await context.user.spendClue(amount)
		return true
	}
}

struct SpendClueParser: ExpressionParser {
	let head = "spendClue"
	let doc = ExpressionDoc(
		signature: "(spendClue amount:Int?):Bool",
		description: "Spend user's clue. If amount not provided - counted as 1.",
		example: "(spendClue)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Bool> {
		let amount = try reader.readOptionalInt() ?? 1
		return SpendClue(amount: amount).asAny()
	}
}
