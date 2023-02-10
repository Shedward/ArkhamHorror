//
//  CGFloat+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit

extension CGFloat: SKAttributable {
    static let attributeType: SKAttributeType = .float

    var attributeValue: SKAttributeValue {
        .init(float: Float(self))
    }
}
