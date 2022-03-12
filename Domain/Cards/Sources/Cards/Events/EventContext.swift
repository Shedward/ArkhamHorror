//
//  EventContext.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Common

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
	func spendMoney(_ amount: Int) async
	func getMoney(_ amount: Int) async

	var remnantsCount: Int { get }
	func spendRemnant(_ amount: Int) async
	func getRemnant(_ amount: Int) async

	var cluesCount: Int { get }
	func spendClue(_ amount: Int) async
	func getClue(_ amount: Int) async

	func testSkill(_ skill: Skill) async -> Int
}

public protocol GameBoardContext {
	func drawSpell() async
	func drawSpecial(id: Event.Id) async
	func drawItem(expectedRarity: ItemRarity?, expectedCost: CostTest?) async
}

public protocol EventContext {
	var user: UserContext { get }
	var gameBoard: GameBoardContext { get }

	func askUser<Value>(_ question: UserQuestion<Value>) async -> Value
}
