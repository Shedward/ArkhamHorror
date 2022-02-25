//
//  EventContext.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

public struct UserQuestion<Value> {
	struct Answer {
		let title: String
		let value: Value
	}

	let title: String?
	let answers: [Answer]
}

public enum Skill: String {
	case lore
	case influence
	case observation
	case strength
	case will
}

public protocol EventContext {
	func askUser<Value>(_ question: UserQuestion<Value>) async -> Value
	func testSkill(_ skill: Skill) async -> Int
}
