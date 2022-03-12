//
//  BecomeBlessed.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct BecomeBlessed: Expression {
	func resolve(in context: EventContext) async {
		await context.user.becomeBlessed()
	}
}

struct BecomeBlessedParser: ExpressionParser {
	let head = "becomeBlessed"
	let doc = ExpressionDoc(
		signature: "(becomeBlessed)",
		description: "Player become blessed.",
		example: nil
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		BecomeBlessed().asAny()
	}
}
