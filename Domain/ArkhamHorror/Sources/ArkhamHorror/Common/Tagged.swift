//
//  Tagged.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

struct Tagged<Tag, RawValue>: RawRepresentable {
	var rawValue: RawValue

	init(rawValue: RawValue) {
		self.rawValue = rawValue
	}

	func map<B>(_ f: (RawValue) -> B) -> Tagged<Tag, B> {
		return .init(rawValue: f(self.rawValue))
	}
}
