//
//  HStack.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import SpriteKit
import Prelude

public final class Stack: View {
    public let node: SKNode

    public init(axis: Axis, spacing: CGFloat, views: [View]) {
        node = SKNode()

        var currentW: CGFloat = 0.0
        views.forEach { view in
            let childNode = view.node
            let childRect = childNode.calculateAccumulatedFrame()

            var point = CGPoint()
            point[axis: axis] = currentW - childRect.origin[axis: axis]
            childNode.position = point
            node.addChild(childNode)

            currentW += childRect.size[axis: axis] + CGFloat(spacing)
        }

        currentW -= CGFloat(spacing)
        let wOffset = 0.5 * currentW

        views.forEach { view in
            view.node.position[axis: axis] -= wOffset
        }
    }

    convenience init(axis: Axis, spacing: CGFloat, @ArrayBuilder<View> buildViews: () -> [View]) {
        var views = buildViews()
        if case .vertical = axis {
            // Since in SpriteKit Y axis is increasing from bottom to top
            // we revert builder results to be in the same order
            // on the screen as in code (from top to bottom).
            views = views.reversed()
        }
        self.init(axis: axis, spacing: spacing, views: views)
    }
}


