//
//  Centered.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit

public final class Centered: View {
    public let node: SKNode

    init(_ view: View, size: CGSize) {
        node = SKNode()
        let childNode = view.node
        let childSize = childNode.calculateAccumulatedFrame()
        let position = CGPoint(
            x: 0.5 * size.width - 0.5 * childSize.width,
            y: 0.5 * size.height - 0.5 * childSize.height
        )
        childNode.position = position
        node.addChild(childNode)
    }
}
