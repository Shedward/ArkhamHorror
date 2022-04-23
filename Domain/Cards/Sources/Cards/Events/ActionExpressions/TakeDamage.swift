//
//  TakeDamage.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct TakeDamage: Expression {
	let amount: Int
    let target: Set<HealthChangeRequest.Target>

	func resolve(in context: EventContext) async {
		await context.changeHealth(
			.init(
				kind: .damage,
				amount: amount,
				targets: target
			)
		)
	}
}

struct TakeDamageParser: ExpressionParser {
	let head = "takeDamage"
	let doc = ExpressionDoc(
		signature: "(takeDamage <amount>:Int, <healTarget?>:HealTarget):Void",
		description: "Current player and/or ally take damage.",
		example: "(takeDamage 2 (target you ally))"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readInt()
        let healTarget = try reader.readOptionalData(HealTargetParser()) ?? [.you, .ally]
        return TakeDamage(amount: amount, target: healTarget).asAny()
	}
}
