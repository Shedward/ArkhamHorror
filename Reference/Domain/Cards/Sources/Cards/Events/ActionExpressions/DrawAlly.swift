//
//  DrawAlly.swift
//  
//
//  Created by Vladislav Maltsev on 20.03.2022.
//

import Script

struct DrawAlly: Expression {
	func resolve(in context: EventContext) async {
		await context.gameBoard.drawAlly()
	}
}

struct DrawAllyParser: ExpressionParser {
	let head = "drawAlly"
	let doc = ExpressionDoc(
		signature: "(drawAlly):Void",
		description: "Player draws ally",
		example: "(drawAlly)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		DrawAlly().asAny()
	}
}
