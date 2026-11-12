//
//  Point.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit
import simd

extension CGPoint {
    public init(vec2: vector_float2) {
        self.init(x: CGFloat(vec2.x), y: CGFloat(vec2.y))
    }

    public func vec2() -> vector_float2 {
        vector_float2(Float(x), Float(y))
    }
}

extension CGPoint: SKAttributable {
    static let attributeType: SKAttributeType = .vectorFloat2

    var attributeValue: SKAttributeValue {
        .init(vectorFloat2: vec2())
    }
}
