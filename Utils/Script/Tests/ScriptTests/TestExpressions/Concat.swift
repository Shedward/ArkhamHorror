//
//  Concat.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Script

struct Concat<Context>: Expression {
	let lhs: AnyExpression<Context, String>
	let rhs: AnyExpression<Context, String>

	func resolve(in context: Context) async -> String {
		let lhsString = await lhs.resolve(in: context)
		let rhsString = await rhs.resolve(in: context)

		return lhsString + rhsString
	}
}

struct ConcatParser<Context>: ExpressionParser {
	let head = "concat"
	let doc = ExpressionDoc(
		signature: "(concat (oneString):String (twoString):String):String",
		description: """
			Concatenate two string or expressions into one.
		""",
		example: "(concat \"Hello\" (getUserName))"
	)

	func parse(_ reader: ExpressionParameterReader<Context>) throws -> AnyExpression<Context, String> {
		let lhs: AnyExpression<Context, String>
		let rhs: AnyExpression<Context, String>

		if let lhsString = try? reader.readString() {
			lhs = Just(lhsString).asAny()
		} else {
			lhs = try reader.readExpression(String.self)
		}

		if let rhsString = try? reader.readString() {
			rhs = Just(rhsString).asAny()
		} else {
			rhs = try reader.readExpression(String.self)
		}

		return Concat(lhs: lhs, rhs: rhs).asAny()
	}
}
