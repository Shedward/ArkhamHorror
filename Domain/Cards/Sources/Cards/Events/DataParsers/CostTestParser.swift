//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Script

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
