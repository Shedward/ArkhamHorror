//
//  ShopPriceChange.swift
//  
//
//  Created by Vladislav Maltsev on 27.03.2022.
//

public struct ShopPriceChange {
    public let changePrice: (Int) -> Int

    init(changePrice: @escaping (Int) -> Int) {
        self.changePrice = changePrice
    }

    public static let none = ShopPriceChange { $0 }

    public static let half = ShopPriceChange { $0 / 2 }

    public static let free = ShopPriceChange { _ in 0 }

    public static func discount(by discountValue: Int) -> ShopPriceChange {
        ShopPriceChange { $0 + discountValue }
    }

    public func than(_ anotherChange: ShopPriceChange) -> ShopPriceChange {
        ShopPriceChange { price in
            anotherChange.changePrice(self.changePrice(price))
        }
    }
}
