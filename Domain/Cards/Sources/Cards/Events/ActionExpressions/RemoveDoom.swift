//
//  RemoveDoom.swift
//  
//
//  Created by Vladislav Maltsev on 23.04.2022.
//

import Script
import Common

struct RemoveDoom: Expression {
    let count: Int
    let locationLimitaion: LocationLimitation

    func resolve(in context: EventContext) async {
        await context.removeDoom()
    }
}

struct RemoveDoomParser: ExpressionParser {
    let head = "removeDoom"
    let doc = ExpressionDoc(
        signature: "(removeDoom):Bool",
        description: "Allow user to remove doom",
        example: "(removeDoom)"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        let count = try reader.readOptionalInt() ?? 1
        let locationLimitation = try reader.readOptionalRaw(LocationLimitation.self) ?? .any

        return RemoveDoom(count: count, locationLimitaion: locationLimitation).asAny()
    }
}
