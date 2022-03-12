//
//  RestoreHorror.swift
//
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct RestoreHorror: Expression {
	let amount: Int
	let targets: Set<HealthChangeRequest.Target>

	func resolve(in context: EventContext) async {
		await context.changeHealth(
			.init(
				kind: .horror,
				amount: -amount,
				targets: targets
			)
		)
	}
}

struct RestoreHorrorParser: ExpressionParser {
	let head = "restoreHorror"
	let doc = ExpressionDoc(
		signature: "(restoreHorror <amount>:Int <healTarget?>:HealTarget):Void",
		description: "Current player and/or ally restore horror.",
		example: "(restoreHorror 2 (healTarget you))"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readInt()
		let targets = try reader.readData(HealTargetParser())
		return RestoreHorror(amount: amount, targets: targets).asAny()
	}
}
