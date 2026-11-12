//
//  ShopPriceChangesParser.swift
//  
//
//  Created by Vladislav Maltsev on 27.03.2022.
//

import Script
import Common

struct ShopPriceChangeParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> ShopPriceChange {
        switch head {
        case "half":
            return .half
        case "free":
            return .free
        case "discount":
            let amount = try parametersReader.readInt()
            return .discount(by: amount)
        default:
            throw DataError(message: "Not expected operator \(head) for ShopPriceChange")
        }
    }
}

struct ShopPriceChangesParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> ShopPriceChange {
        guard head == "priceChanges" else {
            throw DataError(message: "Expected priceChanges")
        }

        var priceChange = ShopPriceChange.none

        while parametersReader.haveAnotherParameter() {
            let priceChangePart = try parametersReader.readData(ShopPriceChangeParser())
            priceChange = priceChange.than(priceChangePart)
        }

        return priceChange
    }
}
