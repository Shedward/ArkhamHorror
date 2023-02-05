//
//  Size.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import simd
import SpriteKit

public struct Size {
    public var width: Length
    public var height: Length

    public init(width: Length, height: Length) {
        self.width = width
        self.height = height
    }

    public init(size: CGSize) {
        self.init(width: Length(size.width), height: Length(size.height))
    }

    public func cgSize() -> CGSize {
        CGSize(width: CGFloat(width), height: CGFloat(height))
    }

    public init(vec2: vector_float2) {
        self.init(width: vec2.x, height: vec2.y)
    }

    public func vec2() -> vector_float2 {
        vector_float2(width, height)
    }
}

extension Size: SKAttributable {
    static let attributeType: SKAttributeType = .vectorFloat2

    var attributeValue: SKAttributeValue {
        .init(vectorFloat2: vec2())
    }
}
