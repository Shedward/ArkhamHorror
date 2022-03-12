//
//  TakeHorror.swift
//
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct TakeHorror: Expression {
	let amount: Int

	func resolve(in context: EventContext) async {
		await context.changeHealth(
			.init(
				kind: .horror,
				amount: amount,
				targets: [.you, .ally]
			)
		)
	}
}

struct TakeHorrorParser: ExpressionParser {
	let head = "takeHorror"
	let doc = ExpressionDoc(
		signature: "(takeHorror <amount>:Int):Void",
		description: "Current player and/or ally take horror.",
		example: "(takeHorror 2)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readInt()
		return TakeHorror(amount: amount).asAny()
	}
}
