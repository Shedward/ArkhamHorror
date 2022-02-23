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
