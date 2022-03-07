//
//  Concat.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Script

struct Concat<Context>: Expression {
	let strings: [AnyExpression<Context, String>]

	func resolve(in context: Context) async -> String {
		var stringsResult: [String] = []

		for expr in strings {
			stringsResult.append(await expr.resolve(in: context))
		}

		return stringsResult.joined()
	}
}

struct ConcatParser<Context>: ExpressionParser {
	let head = "concat"
	let doc = ExpressionDoc(
		signature: "(concat (oneString):String (twoString):String ...):String",
		description: """
			Concatenate two string or expressions into one.
		""",
		example: "(concat \"Hello\" (getUserName))"
	)

	func parse(_ reader: ExpressionParameterReader<Context>) throws -> AnyExpression<Context, String> {
		var stringExpressions: [AnyExpression<Context, String>] = []

		while reader.haveAnotherParameter() {
			let expr: AnyExpression<Context, String>
			if let lhsString = try? reader.readString() {
				expr = Just(lhsString).asAny()
			} else {
				expr = try reader.readExpression(String.self)
			}

			stringExpressions.append(expr)
		}

		return Concat(strings: stringExpressions).asAny()
	}
}
