//
//  GetRemnant.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct GetRemnant: Expression {
	let amount: Int

	func resolve(in context: EventContext) async {
		await context.user.getRemnant(amount)
	}
}

struct GetRemnantParser: ExpressionParser {
	let head = "getRemnant"
	let doc = ExpressionDoc(
		signature: "(getRemnant <amount?>:Int):Void",
		description: "User gets remnants. If amount not provided it counted as 1.",
		example: "(getRemnant)"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let amount = try reader.readOptionalInt() ?? 1
		return GetRemnant(amount: amount).asAny()
	}
}
