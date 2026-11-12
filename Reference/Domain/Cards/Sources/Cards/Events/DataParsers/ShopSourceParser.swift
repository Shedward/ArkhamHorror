//
//  ShopSourceParser.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Script
import Common

struct ShopSourceParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> ShopSource {
        switch head {
        case "showcase":
            return .showcase
        case "draw":
            let count = try parametersReader.readInt()
            return .draw(count: count)
        default:
            throw DataError(message: "Not expected operator \(head) for ShopSource")
        }
    }
}
