//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Script
import Common

struct PriceTestParser: DataParser {
    func parse(
        head: String,
        parametersReader: ExpressionParameterReader<EventContext>
    ) throws -> PriceTest {
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

        return PriceTest { op($0, value) }
    }
}
