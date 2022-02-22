//
//  DoNothing.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct DoNothing<Context>: Expression {
	public init() {
	}

	public func resolve(in context: Context) async {
	}
}
