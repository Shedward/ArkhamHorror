//
//  BecomeDelayedTest.swift
//  
//
//  Created by Vladislav Maltsev on 23.04.2022.
//

import Script

struct BecomeDelayedTest: Expression {
    func resolve(in context: EventContext) async -> Bool {
        await context.player.becomeDelayed()
        return true
    }
}

struct BecomeDelayedTestParser: ExpressionParser {
    let head = "becomeDelayed"
    let doc = ExpressionDoc(
        signature: "(becomeDelayed):Bool",
        description: "Player become delayed.",
        example: nil
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Bool> {
        BecomeDelayedTest().asAny()
    }
}

