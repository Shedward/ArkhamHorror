//
//  FadeTransition.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

import SpriteKit
import SceneKit

public struct FadeSpriteTransition: NodeTransition {
    public let duration: TimeInterval

    public init(duration: TimeInterval = 0.25) {
        self.duration = duration
    }

    public func enter(node: SKNode, in parent: SKNode) {
        node.alpha = 0.0
        parent.addChild(node)
        node.run(.fadeIn(withDuration: duration))
    }

    public func leave(node: SKNode, in parent: SKNode) {
        node.run(.fadeOut(withDuration: duration)) {
            node.removeFromParent()
        }
    }
}
