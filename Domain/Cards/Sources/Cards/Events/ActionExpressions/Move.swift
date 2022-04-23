//
//  Move.swift
//  
//
//  Created by Vladislav Maltsev on 23.04.2022.
//

import Script

struct Move: Expression {
    let maxAmount: Int

    func resolve(in context: EventContext) async {
        await context.player.move(maxAmount)
    }
}

struct MoveParser: ExpressionParser {
    let head = "move"
    let doc = ExpressionDoc(
        signature: "(move <maxAmount?>:Int):Void",
        description: "Allow player to move to maximum `maxAmount` tiles from it's current position.",
        example: "(move 2)"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        let maxAmount = try reader.readOptionalInt() ?? 1
        return Move(maxAmount: maxAmount).asAny()
    }
}
