//
//  Frame.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import DesignSystem
import Prelude

public final class Frame: View {
    public var node: SKNode { frameNode }

    private let frameNode: SKShapeNode
    private let designSystem = DesignSystem.default
    private let insets: CGEdgeInsets

    public init(
        stroke: DesignSystem.ColorKind?,
        borderWidth: CGFloat = 4,
        insets: CGEdgeInsets = .zero,
        fill: DesignSystem.ColorKind? = nil
    ) {
        let frameNode = SKShapeNode()
        if let fill {
            frameNode.fillColor = designSystem.color.by(fill)
        }
        if let stroke {
            frameNode.strokeColor = designSystem.color.by(stroke)
        }
        frameNode.lineWidth = borderWidth
        self.frameNode = frameNode
        self.insets = insets
    }

    @discardableResult
    public func reframe() -> CGRect {
        let framingRect = node.calculateAccumulatedFrame()
        let insetedRect = framingRect.inset(by: insets)
        frameNode.path = CGPath(rect: insetedRect, transform: nil)
        return insetedRect
    }
}
