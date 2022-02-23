//
//  Expression.swift
//
//
//  Created by Vladislav Maltsev on 23.03.2022.
//

public protocol Expression {
	associatedtype Context
	associatedtype Result

	func resolve(in context: Context) async -> Result
}

public struct AnyExpression<Context, Result>: Expression {
	private let resolveAction: (Context) async -> Result

	init<A: Expression>(_ wrapped: A) where A.Context == Context, A.Result == Result {
		resolveAction = wrapped.resolve
	}

	public func resolve(in context: Context) async -> Result {
		await resolveAction(context)
	}
}

extension Expression {
	public func asAny() -> AnyExpression<Context, Result> {
		AnyExpression(self)
	}
}
