//
//  SpendMoney.swift
//  
//
//  Created by Vladislav Maltsev on 26.02.2022.
//

import Script

struct SpendMoney: Expression {
	let amount: Int

	func resolve(in context: EventContext) async -> Bool {
		guard context.user.money > amount else {
			return false
		}

		await context.user.spendMoney(amount)
		return true
	}
}

struct SpendMoneyParser: ExpressionParser {
	let head = "spendMoney"
	let doc = ExpressionDoc(
		signature: #"(spendMoney amount:Int):Bool"#,
		description: "Spend money",
		example: "(spendMoney 2)"
	)

	func parse(_ reader: ExpressionParameterReader<EventContext>) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readInt()
		return SpendMoney(amount: amount).asAny()
	}
}

