//
//  BecomeCursed.swift
//
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct BecomeCursed: Expression {
	func resolve(in context: EventContext) async {
		await context.user.becomeCursed()
	}
}

struct BecomeCursedParser: ExpressionParser {
	let head = "becomeCursed"
	let doc = ExpressionDoc(
		signature: "(becomeCursed)",
		description: "Player become cursed.",
		example: nil
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		BecomeCursed().asAny()
	}
}
