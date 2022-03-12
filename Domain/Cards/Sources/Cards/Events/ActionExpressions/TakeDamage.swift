//
//  TakeDamage.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct TakeDamage: Expression {
	let amount: Int

	func resolve(in context: EventContext) async {
		await context.changeHealth(
			.init(
				kind: .damage,
				amount: amount,
				targets: [.you, .ally]
			)
		)
	}
}

struct TakeDamageParser: ExpressionParser {
	let head = "takeDamage"
	let doc = ExpressionDoc(
		signature: "(takeDamage <amount>:Int):Void",
		description: "Current player and/or ally take damage.",
		example: "(takeDamage 2)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readInt()
		return TakeDamage(amount: amount).asAny()
	}
}
