//
//  ItemLimitations.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

public struct ShopLimitations {
    public var expectedRarity: Set<ItemRarity>
    public var expectedCost: CostTest
    public var maxAmount: Int?

    public init(
        expectedRarity: Set<ItemRarity> = [],
        expectedCost: CostTest = .init { _ in true },
        maxAmount: Int? = nil
    ) {
        self.expectedRarity = expectedRarity
        self.expectedCost = expectedCost
        self.maxAmount = maxAmount
    }
}
