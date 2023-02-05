//
//  SKAttributable.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

protocol SKAttributable {
    static var attributeType: SKAttributeType { get }
    var attributeValue: SKAttributeValue { get }
}
