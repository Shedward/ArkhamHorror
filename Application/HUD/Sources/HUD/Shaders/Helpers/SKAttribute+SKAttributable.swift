//
//  SKAttribute+SKAttributable.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

extension SKAttribute {
    convenience init<T: SKAttributable, K: RawRepresentable>(
        named name: K,
        type: T.Type
    ) where K.RawValue == String {
        self.init(name: name.rawValue, type: T.attributeType)
    }
}
