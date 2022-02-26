//
//  SpendRemnant.swift
//  
//
//  Created by Vladislav Maltsev on 26.02.2022.
//

import Script

struct SpendRemnant: Expression {
	let amount: Int

	func resolve(in context: EventContext) async -> Bool {
		guard context.user.remnantsCount > amount else {
			return false
		}

		await context.user.spendRemnant(amount)
		return true
	}
}

struct SpendRemnantParser: ExpressionParser {
	let head = "spendRemnant"
	let doc = ExpressionDoc(
		signature: #"(spendRemnant amount:Int?):Bool"#,
		description: "Spend user's remnant. If amount not provided - counted as 1.",
		example: "(spendRemnant 2)"
	)

	func parse(_ reader: ExpressionParameterReader<EventContext>) throws -> AnyExpression<EventContext, Bool> {
		let amount = try reader.readInt()
		return SpendRemnant(amount: amount).asAny()
	}
}
