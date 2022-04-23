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
        signature: "(shop <source>:ShopSource <limits?>:ShopItemLimitations <priceChanges?>:ShopPriceChanges):Void",
        description: """
        Open shop for player to buy.
        Parameters:
            - source - source from which player can buy items:
                - (showcase) - Player can buy from open showcase
                - (draw N) - Player can draw n cards and buy items from it, the rest
                    should be shuffled back.
            - limits - list of limitations on buying items:
                (limits <limitation1> <limitation2> ...)
                Empty limitations `(limitations)` list means - any item can be bought.
                Possible limitations:
                    - (rarity <rarity1> <rarity2> ...) - only items with selected rarity could be bought.
                        Rarities: common, rare
                    - (maxCount N) - only N or less items could be bought.
                    - (price <priceTest>:PriceTest) - only items with price passing price test
                        could be bought
            - priceChanges - list of effects applying on prices in the shop:
                (priceChanges <priceChange1> <priceChange2> ...)
                Price changes applies one after another.
                Possible price changes:
                    - (half) - prices reduced by 50%
                    - (free) - prices droped to 0
                    - (none) - prices stays the same
                    - (discount N) - prices reduced by N

        """,
        example: "(shop (showcase) (limits (price (lessThan 3))))"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        let source = try reader.readData(ShopSourceParser())
        let limitations = try reader.readOptionalData(ShopItemLimitationsParser())
        let priceChange = try reader.readOptionalData(ShopPriceChangesParser())
        return Shop(
            source: source,
            limitations: limitations ?? .init(),
            priceChange: priceChange ?? .none
        ).asAny()
    }
}
