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
	let expectedCost: CostTest?

	func resolve(in context: EventContext) async {
		await context.gameBoard.drawItem(expectedRarity: expectedRarity, expectedCost: expectedCost)
	}
}

struct CostTestParser: DataParser {
	func parse(
		head: String,
		parametersReader: ExpressionParameterReader<EventContext>
	) throws -> CostTest {
		let op: (Int, Int) -> Bool
		let value = try parametersReader.readInt()

		switch head {
		case "equalTo":
			op = (==)
		case "lessThan":
			op = (<)
		case "lessOrEqualThan":
			op = (<=)
		case "greaterThan":
			op = (>)
		case "greaterOrEqualThan":
			op = (>=)
		default:
			throw DataError(message: "Not expected operator \(head) for CostTest")
		}

		return CostTest { op($0, value) }
	}
}

struct DrawItemParser: ExpressionParser {
	let head = "drawItem"
	let doc = ExpressionDoc(
		signature: #"(drawItem <rarity?>:ItemRarity <cost?>:CostTest):Void"#,
		description: """
		Draw first item that apply to selected rules.
		Possible rarities: nil, common, rare
		Possible costs: nil, (equalTo N), (lessThan N), (lessOrEqualThan N),
			(greaterThan N), (greaterOrEqualThan N)
		""",
		example: "(drawItem common (lessThan 4))"
	)

	func parse(
		_ reader: ExpressionParameterReader<EventContext>
	) throws -> AnyExpression<EventContext, Void> {
		let rarity = try? reader.readRaw(ItemRarity.self)
		let costTest = try? reader.readData(CostTestParser())

		return DrawItem(expectedRarity: rarity, expectedCost: costTest).asAny()
	}
}
