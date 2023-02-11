//
//  View.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

public protocol View: AnyObject {
    var node: SKNode { get }
}
