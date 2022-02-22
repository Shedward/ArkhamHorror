//
//  Do.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct Do<Context>: Expression {
	private let actions: [AnyAction<Context>]

	public init(_ actions: AnyAction<Context>...) {
		self.actions = actions
	}

	public func resolve(in context: Context) async {
		for action in actions {
			await action.resolve(in: context)
		}
	}
}
