//
//  SKNode+SKAttributable.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

extension SKSpriteNode {
    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String {
        setValue(value.attributeValue, forAttribute: attribute.rawValue)
    }
}

extension SKEffectNode {
    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String {
        setValue(value.attributeValue, forAttribute: attribute.rawValue)
    }
}

extension SKShapeNode {
    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String {
        setValue(value.attributeValue, forAttribute: attribute.rawValue)
    }
}
