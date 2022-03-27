//
//  DrawItem.swift
//  
//
//  Created by Vladislav Maltsev on 07.03.2022.
//

import Script
import Common

struct DrawItem: Expression {
	let expectedRarity: ItemRarity?
	let expectedPrice: PriceTest?

	func resolve(in context: EventContext) async {
		await context.gameBoard.drawItem(expectedRarity: expectedRarity, expectedCost: expectedPrice)
	}
}

struct DrawItemParser: ExpressionParser {
	let head = "drawItem"
	let doc = ExpressionDoc(
		signature: #"(drawItem <rarity?>:ItemRarity <cost?>:CostTest):Void"#,
		description: """
		Draw first item that apply to selected rules.
		Possible rarities: nil, common, rare
		Possible price: nil, (equalTo N), (lessThan N), (lessOrEqualThan N),
			(greaterThan N), (greaterOrEqualThan N)
		""",
		example: "(drawItem common (lessThan 4))"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let rarity = try? reader.readRaw(ItemRarity.self)
		let priceTest = try? reader.readData(PriceTestParser())

		return DrawItem(expectedRarity: rarity, expectedPrice: priceTest).asAny()
	}
}
