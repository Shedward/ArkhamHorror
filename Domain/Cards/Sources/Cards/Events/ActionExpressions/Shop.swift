//
//  Shop.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

import Common
import Script

struct Shop: Expression {
    let source: ShopSource
    let limitations: ShopLimitations

    func resolve(in context: EventContext) async {
        await context.shop(from: source, limitations: limitations)
    }
}
