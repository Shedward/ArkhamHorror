//
//  SKNode+SKAttributable.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

protocol SKAttributableNode: SKNode {
    var shader: SKShader? { get set }

    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String
}

extension SKSpriteNode: SKAttributableNode {
    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String {
        setValue(value.attributeValue, forAttribute: attribute.rawValue)
    }
}

extension SKEffectNode: SKAttributableNode {
    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String {
        setValue(value.attributeValue, forAttribute: attribute.rawValue)
    }
}

extension SKShapeNode: SKAttributableNode {
    var shader: SKShader? {
        get { fillShader }
        set { fillShader = newValue }
    }

    func setValue<T: SKAttributable, K: RawRepresentable>(
        _ value: T,
        forAttribute attribute: K
    ) where K.RawValue == String {
        setValue(value.attributeValue, forAttribute: attribute.rawValue)
    }
}
