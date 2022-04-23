//
//  DrawSpell.swift
//  
//
//  Created by Vladislav Maltsev on 26.02.2022.
//

import Script

struct DrawSpell: Expression {
	func resolve(in context: EventContext) async -> Void {
		await context.gameBoard.drawSpell()
	}
}

struct DrawSpellParser: ExpressionParser {
	let head = "drawSpell"
	let doc = ExpressionDoc(
		signature: "(drawSpell)",
		description: "Current player draw a spell",
		example: "(drawSpell)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		DrawSpell().asAny()
	}
}
