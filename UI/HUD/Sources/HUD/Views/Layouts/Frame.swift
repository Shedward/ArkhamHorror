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
    public private(set) var lastFrame: CGRect = .zero

    private let frameNode: SKShapeNode
    private let designSystem = DesignSystem.default
    private let insets: CGEdgeInsets

    public init(
        stroke: DesignSystem.ColorKind?,
        borderWidth: CGFloat = 4,
        insets: CGEdgeInsets = .zero,
        fill: DesignSystem.ColorKind? = nil
    ) {
        frameNode = SKShapeNode()
        if let fill {
            frameNode.fillColor = designSystem.color.by(fill)
        }
        if let stroke {
            frameNode.strokeColor = designSystem.color.by(stroke)
        }
        frameNode.lineWidth = borderWidth

        self.insets = insets
        super.init(node: frameNode)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let framingRect = node.calculateAccumulatedFrame()
        let insetedRect = framingRect.inset(by: insets)
        frameNode.path = CGPath(rect: insetedRect, transform: nil)
        lastFrame = insetedRect
    }
}
