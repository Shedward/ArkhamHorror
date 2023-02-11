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
    public var axis: Axis
    public var spacing: CGFloat

    public init(axis: Axis, spacing: CGFloat, views: [View]) {
        let node = SKNode()

        views.forEach { view in
            node.addChild(view.node)
        }

        self.node = node
        self.axis = axis
        self.spacing = spacing
    }

    public convenience init(axis: Axis, spacing: CGFloat, @ArrayBuilder<View> buildViews: () -> [View]) {
        var views = buildViews()
        if case .vertical = axis {
            // Since in SpriteKit Y axis is increasing from bottom to top
            // we revert builder results to be in the same order
            // on the screen as in code (from top to bottom).
            views = views.reversed()
        }
        self.init(axis: axis, spacing: spacing, views: views)
    }

    public func layoutSubviews() {
        let nodes = node.children

        var currentW: CGFloat = 0.0
        nodes.forEach { childNode in
            let childRect = childNode.calculateAccumulatedFrame()

            var point = CGPoint()
            point[axis: axis] = currentW - childRect.origin[axis: axis]
            childNode.position = point

            currentW += childRect.size[axis: axis] + CGFloat(spacing)
        }

        currentW -= CGFloat(spacing)
        let wOffset = 0.5 * currentW

        nodes.forEach { node in
            node.position[axis: axis] -= wOffset
        }
    }
}


