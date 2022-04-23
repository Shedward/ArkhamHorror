//
//  RestoreDamage.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct RestoreDamage: Expression {
	let amount: Int
	let targets: Set<HealthChangeRequest.Target>

	func resolve(in context: EventContext) async {
        await context.player.changeHealth(
			.init(
				kind: .damage,
				amount: -amount,
				targets: targets
			)
		)
	}
}

struct RestoreDamageParser: ExpressionParser {
	let head = "restoreDamage"
	let doc = ExpressionDoc(
		signature: "(restoreDamage <amount>:Int <healTarget?>:HealTarget):Void",
		description: "Current player and/or ally restore damage.",
		example: "(restoreDamage 2 (healTarget you))"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readInt()
		let targets = try reader.readData(HealTargetParser())
		return RestoreDamage(amount: amount, targets: targets).asAny()
	}
}
