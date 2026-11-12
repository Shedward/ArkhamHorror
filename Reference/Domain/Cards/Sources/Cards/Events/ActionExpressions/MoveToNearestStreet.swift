//
//  MoveToNearestStreet.swift
//  
//
//  Created by Vladislav Maltsev on 23.04.2022.
//

import Script

struct MoveToNearestStreet: Expression {
    func resolve(in context: EventContext) async {
        await context.currentPlayer.moveToNearestStreet()
    }
}

struct MoveToNearestStreetParser: ExpressionParser {
    let head = "moveToNearestStreet"
    let doc = ExpressionDoc(
        signature: "(moveToNearestStreet):Void",
        description: "Move player to nearest street",
        example: "(moveToNearestStreet)"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        MoveToNearestStreet().asAny()
    }
}
