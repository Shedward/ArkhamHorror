//
//  EventContext.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Common

public struct Question<Value> {
	struct Answer {
		let title: String
		let value: Value
	}

	let title: String?
	let answers: [Answer]
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

public protocol PlayerContext {
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

    func move(_ maxAmount: Int) async
    func moveToNearestStreet() async

    func changeHealth(_ request: HealthChangeRequest) async
    func ask<Value>(_ question: Question<Value>) async -> Value
}

public protocol GameBoardContext {
	func drawSpell() async
	func drawAlly() async
	func drawSpecial(id: Event.Id) async
	func drawItem(expectedRarity: ItemRarity?, expectedCost: PriceTest?) async
    func removeDoom() async
}

public protocol EventContext {
	var player: PlayerContext { get }
	var gameBoard: GameBoardContext { get }

    func shop(
        from source: ShopSource,
        limitations: ShopItemLimitations,
        priceChange: ShopPriceChange
    ) async
}
