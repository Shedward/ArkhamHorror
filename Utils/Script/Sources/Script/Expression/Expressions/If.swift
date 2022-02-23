//
//  If.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct If<Context, Result>: Expression {
	private let test: AnyPredicate<Context>
	private let onSuccess: AnyExpression<Context, Result>
	private let onFailure: AnyExpression<Context, Result>

	public init(
		_ test: AnyPredicate<Context>,
		then onSuccess: AnyExpression<Context, Result>,
		else onFailure: AnyExpression<Context, Result>
	) {
		self.test = test
		self.onSuccess = onSuccess
		self.onFailure = onFailure
	}

	public func resolve(in context: Context) async -> Result {
		if await test.resolve(in: context) {
			return await onSuccess.resolve(in: context)
		} else {
			return await onFailure.resolve(in: context)
		}
	}
}

public struct IfParser<Context, Result>: SParser {
	public let head = "if"
	public let doc = SParserDoc(
		signature: "(if (test):Bool (then):Some (else):Some): Some",
		description: """
		Check test, if it returns true - resolve `then` action,
		if it returns false - resolve `else` action.
		""",
		example: "(if (healthBiggerThan 5) (doNothing) (heal 10))"
	)

	public func parse(_ reader: SReader<Context>) throws -> AnyExpression<Context, Result> {
		let test = try reader.readExpression(Bool.self)
		let thenExpression = try reader.readExpression(Result.self)
		let elseExpression = try reader.readExpression(Result.self)

		return If(test, then: thenExpression, else: elseExpression).asAny()
	}
}
