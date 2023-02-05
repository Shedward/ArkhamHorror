//
//  HStack.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import SpriteKit

public final class HStack: View {
    public let node: SKNode

    init(views: View..., spacing: Length) {
        node = SKNode()


        var originX: CGFloat = 0.0
        views.forEach { view in

            let childNode = view.node
            childNode.position = CGPoint(x: originX, y: 0)
            let childSize = childNode.calculateAccumulatedFrame()
            originX += childSize.width + CGFloat(spacing)
            node.addChild(childNode)
        }
    }
}
