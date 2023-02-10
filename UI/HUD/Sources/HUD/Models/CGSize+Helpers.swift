//
//  Size.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import simd
import SpriteKit

extension CGSize {
    public init(vec2: vector_float2) {
        self.init(width: CGFloat(vec2.x), height: CGFloat(vec2.y))
    }

    public func vec2() -> vector_float2 {
        vector_float2(Float(width), Float(height))
    }
}

extension CGSize: SKAttributable {
    static let attributeType: SKAttributeType = .vectorFloat2

    var attributeValue: SKAttributeValue {
        .init(vectorFloat2: vec2())
    }
}
