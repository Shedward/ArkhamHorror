//
//  Script.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

public struct Script<Context, Result> {
	private let rootExpression: AnyExpression<Context, Result>

	public init(rootExpression: AnyExpression<Context, Result>) {
		self.rootExpression = rootExpression
	}

	public func run(in context: Context) async -> Result {
		await rootExpression.resolve(in: context)
	}
}
