//
//  GetMoney.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct GetMoney: Expression {
	let amount: Int

	func resolve(in context: EventContext) async {
		await context.user.getMoney(amount)
	}
}

struct GetMoneyParser: ExpressionParser {
	let head = "getMoney"
	let doc = ExpressionDoc(
		signature: "(getMoney <amount?>:Int):Void",
		description: "User gets money. If amount not provided it counted as 1.",
		example: "(getMoney)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = (try? reader.readInt()) ?? 1
		return GetMoney(amount: amount).asAny()
	}
}
