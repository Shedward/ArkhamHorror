//
//  DrawSpecial.swift
//  
//
//  Created by Vladislav Maltsev on 04.03.2022.
//

import Prelude
import Common
import Script

struct DrawSpecial: Expression {
	let cardId: Event.ID

	func resolve(in context: EventContext) async {
		await context.gameBoard.drawSpecial(id: cardId)
	}
}

struct DrawSpecialParser: ExpressionParser {
	let head = "drawSpecial"
	let doc = ExpressionDoc(
		signature: #"(drawSpecial "cardId":Event.Id):Void"#,
		description: "Players draws special card with specific id",
		example: #"(drawSpecial "some_special_card")"#
	)
	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let cardIdString = try reader.readString()
		let cardId = Event.ID(rawValue: cardIdString)
		return DrawSpecial(cardId: cardId).asAny()
	}
}

