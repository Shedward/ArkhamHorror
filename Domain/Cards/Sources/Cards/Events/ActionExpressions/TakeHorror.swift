//
//  TakeHorror.swift
//
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct TakeHorror: Expression {
    let amount: Int
    let target: Set<HealthChangeRequest.Target>

    func resolve(in context: EventContext) async {
        await context.player.changeHealth(
            .init(
                kind: .horror,
                amount: amount,
                targets: target
            )
        )
    }
}

struct TakeHorrorParser: ExpressionParser {
    let head = "takeHorror"
    let doc = ExpressionDoc(
        signature: "(takeHorror <amount>:Int, <healTarget?>:HealTarget):Void",
        description: "Current player and/or ally take horror.",
        example: "(takeHorror 2 (target you ally))"
    )

    func parse(
        _ reader: ExpressionParameterReader<EventContext>
    ) throws -> AnyExpression<EventContext, Void> {
        let amount = try reader.readInt()
        let healTarget = try reader.readOptionalData(HealTargetParser()) ?? [.you, .ally]
        return TakeDamage(amount: amount, target: healTarget).asAny()
    }
}
