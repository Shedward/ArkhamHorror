//
//  Scalar+SKAttributable.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

extension Bool: SKAttributable {
    static var attributeType: SKAttributeType = .float

    var attributeValue: SKAttributeValue {
        SKAttributeValue(float: self ? 1.0 : 0.0)
    }
}

extension Float: SKAttributable {
    static let attributeType: SKAttributeType = .float

    var attributeValue: SKAttributeValue {
        SKAttributeValue(float: self)
    }
}
