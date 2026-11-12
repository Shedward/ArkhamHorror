//
//  ItemLimitations.swift
//  
//
//  Created by Vladislav Maltsev on 26.03.2022.
//

public struct ShopItemLimitations {
    public var expectedRarity: Set<ItemRarity>
    public var expectedPrice: PriceTest
    public var maxAmount: Int?

    public init(
        expectedRarity: Set<ItemRarity> = [],
        expectedPrice: PriceTest = .init { _ in true },
        maxAmount: Int? = nil
    ) {
        self.expectedRarity = expectedRarity
        self.expectedPrice = expectedPrice
        self.maxAmount = maxAmount
    }
}
