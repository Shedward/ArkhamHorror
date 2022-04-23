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
        signature: "(removeDoom <amount:Int?> <location:LocationLimitation?>):Bool",
        description: """
        Allow user to remove doom.
        Parameters:
            - amount: Int?
              Amount of doom player can remove. If not presented - counts as 1.
            - location: LocationLimitation?
              From what location user can remove doom. Possible values: any, currentNeighborhood,
              currentRegion. If not presented - counts as any.
        """,
        example: "(removeDoom 1 currentRegion)"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        let count = try reader.readOptionalInt() ?? 1
        let locationLimitation = try reader.readOptionalRaw(LocationLimitation.self) ?? .any

        return RemoveDoom(count: count, locationLimitaion: locationLimitation).asAny()
    }
}
