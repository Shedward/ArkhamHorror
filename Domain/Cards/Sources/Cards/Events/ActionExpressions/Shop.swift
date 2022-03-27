//
//  Shop.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Common
import Script

struct Shop: Expression {
    let source: ShopSource
    let limitations: ShopItemLimitations
    let priceChange: ShopPriceChange

    func resolve(in context: EventContext) async {
        await context.shop(
            from: source,
            limitations: limitations,
            priceChange: priceChange
        )
    }
}

struct ShopParser: ExpressionParser {
    let head = "shop"
    let doc = ExpressionDoc(
        signature: "(shop <source>:ShopSource <limitations>: ShopItemLimitations):Void",
        description: """
        Open shop for user to buy.
        Parameters:
            - source - source from which user can buy items:
                - (showcase) - User can buy from open showcase
                - (draw N) - User can draw n cards and buy items from it, the rest
                    should be shuffled back.
            - (limitations <limitation1> <limitation2> ...) - list of limitations on buying items:
                Empty limitations `(limitations)` list means - any item can be bought.
                Possible limitations:
                    - (rarity <rarity1> <rarity2> ...) - only items with selected rarity could be bought.
                        Rarities: common, rare
                    - (maxCount N) - only N or less items could be bought.
                    - (price <priceTest>:PriceTest) - only items with price passing price test
                        could be bought

        """,
        example: "(shop (showcase) (limits (price (lessThan 3))))"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        let source = try reader.readData(ShopSourceParser())
        let limitations = try reader.readData(ShopItemLimitationsParser())
        let priceChange = try reader.readData(ShopPriceChangesParser())
        return Shop(
            source: source,
            limitations: limitations,
            priceChange: priceChange
        ).asAny()
    }
}
