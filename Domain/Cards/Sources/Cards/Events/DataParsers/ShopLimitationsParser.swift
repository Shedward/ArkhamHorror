//
//  ShopLimitationsParser.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Script
import Common

struct ShopLimitationParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<Context>
    ) throws -> (inout ShopLimitations) -> Void {
        switch head {
        case "quality":
            while parametersReader.haveAnotherParameter() {
                
            }
        case "maxCount":
            let count = try parametersReader.readInt()
            return { $0.maxAmount = count }
        case "price":
        }
    }
}

struct ShopLimitationsParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> ShopLimitations {
        <#code#>
    }
}
