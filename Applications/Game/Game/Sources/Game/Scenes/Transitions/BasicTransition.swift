//
//  BasicTransition.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit

struct BasicSpriteTransition: NodeTransition {
    func enter(node: SKNode, in parent: SKNode) {
        parent.addChild(node)
    }

    func leave(node: SKNode, in parent: SKNode) {
        node.removeFromParent()
    }
}

struct BasicSceneTransition: NodeTransition {
    func enter(node: SCNNode, in parent: SCNNode) {
        parent.addChildNode(node)
    }

    func leave(node: SCNNode, in parent: SCNNode) {
        node.removeFromParentNode()
    }
}
