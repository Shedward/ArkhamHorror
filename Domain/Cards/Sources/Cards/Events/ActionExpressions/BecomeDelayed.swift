//
//  BecomeDelayed.swift
//
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct BecomeDelayed: Expression {
	func resolve(in context: EventContext) async {
		await context.currentPlayer.becomeDelayed()
	}
}

struct BecomeDelayedParser: ExpressionParser {
	let head = "becomeDelayed"
	let doc = ExpressionDoc(
		signature: "(becomeDelayed):Void",
		description: "Player become delayed.",
		example: nil
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		BecomeDelayed().asAny()
	}
}
