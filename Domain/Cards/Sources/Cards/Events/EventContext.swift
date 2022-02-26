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

public protocol UserContext {
	var money: Int { get }
	func spendMoney(_ amount: Int) async -> Void

	var remnantsCount: Int { get }
	func spendRemnant(_ amount: Int) async -> Void

	var cluesCount: Int { get }
	func spendClue(_ amount: Int) async -> Void

	func testSkill(_ skill: Skill) async -> Int
}

public protocol EventContext {
	var user: UserContext { get }

	func askUser<Value>(_ question: UserQuestion<Value>) async -> Value
}
