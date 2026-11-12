//
//  ShopItemLimitationsParser.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Script
import Common

struct ShopItemLimitationParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> (inout ShopItemLimitations) -> Void {
        switch head {
        case "rarity":
            var rarities: [ItemRarity] = []
            while parametersReader.haveAnotherParameter() {
                rarities.append(try parametersReader.readRaw(ItemRarity.self))
            }
            guard !rarities.isEmpty else {
                throw DataError(message: "Rarities list could not be empty.")
            }
            return { $0.expectedRarity = Set(rarities) }
        case "maxCount":
            let count = try parametersReader.readInt()
            return { $0.maxAmount = count }
        case "price":
            let costTest = try parametersReader.readData(PriceTestParser())
            return { $0.expectedPrice = costTest }
        default:
            throw DataError(message: "Not expected operator '\(head)' for ShopItemLimitation")
        }
    }
}

struct ShopItemLimitationsParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> ShopItemLimitations {
        guard head == "limits" else {
            throw DataError(message: "Expected limits, found '\(head)'")
        }

        var limitations = ShopItemLimitations()

        while parametersReader.haveAnotherParameter() {
            let limitationPart = try parametersReader.readData(ShopItemLimitationParser())
            limitationPart(&limitations)
        }

        return limitations
    }
}
