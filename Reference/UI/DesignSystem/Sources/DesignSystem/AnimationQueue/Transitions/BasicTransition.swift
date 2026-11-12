//
//  BasicTransition.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit

public struct BasicSpriteTransition: NodeTransition {
    public init() {
    }

    public func enter(node: SKNode, in parent: SKNode) {
        parent.addChild(node)
    }

    public func leave(node: SKNode, in parent: SKNode) {
        node.removeFromParent()
    }
}

public struct BasicSceneTransition: NodeTransition {
    public init() {
    }

    public func enter(node: SCNNode, in parent: SCNNode) {
        parent.addChildNode(node)
    }

    public func leave(node: SCNNode, in parent: SCNNode) {
        node.removeFromParentNode()
    }
}
