//
//  HashRandom.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//

import Foundation

extension Float {
    public static func hashRandom<T: Hashable>(from minValue: Float, to maxValue: Float, for id: T) -> Float {
        let progress = abs(Float(id.hashValue) / Float(Int.max))
        let value = (maxValue - minValue) * progress + minValue
        return value
    }
}

extension Collection where Index == Int {
    public func hashRandomElement<T: Hashable>(for id: T) -> Element? {
        guard !isEmpty else { return nil }

        let index = id.hashValue % count
        return self[index]
    }
}
