//
//  String.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Script

struct Just<Context, Result>: Expression {
	let value: Result

	init(_ value: Result) {
		self.value = value
	}

	func resolve(in context: Context) async -> Result {
		value
	}
}
