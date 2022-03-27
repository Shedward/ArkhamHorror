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

public struct HealthChangeRequest {
	enum Kind {
		case damage
		case horror
	}

	enum Target: String {
		case you
		case ally
		case investigators
	}

	let kind: Kind
	let amount: Int
	let targets: Set<Target>
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

	func becomeBlessed() async
	func becomeCursed() async
	func becomeDelayed() async
}

public protocol GameBoardContext {
	func drawSpell() async
	func drawAlly() async
	func drawSpecial(id: Event.Id) async
	func drawItem(expectedRarity: ItemRarity?, expectedCost: PriceTest?) async
}

public protocol EventContext {
	var user: UserContext { get }
	var gameBoard: GameBoardContext { get }

	func askUser<Value>(_ question: UserQuestion<Value>) async -> Value
	func changeHealth(_ request: HealthChangeRequest) async
    func shop(
        from source: ShopSource,
        limitations: ShopItemLimitations,
        priceChange: ShopPriceChange
    ) async
}
