//
//  Point.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit
import simd

public struct Point {
    public var x: Length
    public var y: Length

    static let zero = Point(x: 0, y: 0)

    public init(x: Length, y: Length) {
        self.x = x
        self.y = y
    }

    public init(point: CGPoint) {
        self.init(x: Length(point.x), y: Length(point.y))
    }

    public func cgPoint() -> CGPoint {
        CGPoint(x: CGFloat(x), y: CGFloat(y))
    }

    public init(vec2: vector_float2) {
        self.init(x: vec2.x, y: vec2.y)
    }

    public func vec2() -> vector_float2 {
        vector_float2(x, y)
    }
}

extension Point: SKAttributable {
    static let attributeType: SKAttributeType = .vectorFloat2

    var attributeValue: SKAttributeValue {
        .init(vectorFloat2: vec2())
    }
}
