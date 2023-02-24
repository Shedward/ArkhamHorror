//
//  AnchoredOver.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2023.
//

import SpriteKit
import Prelude

public final class AnchoredOver: View {
    private let content: View
    private let containerSize: CGSize
    private let containerInsets: CGFloat
    private let offsetFromAnchor: CGFloat
    private weak var anchor: View?
    private let logger = Logger()

    public init(
        _ content: View,
        over anchor: View,
        containerSize: CGSize,
        containerInsets: CGFloat = 16,
        offsetFromAnchor: CGFloat = 16
    ) {
        self.content = content
        self.containerSize = containerSize
        self.containerInsets = containerInsets
        self.offsetFromAnchor = offsetFromAnchor
        self.anchor = anchor
        super.init()
        addChild(content)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard let anchor else {
            logger.warning("""
            Tried to layout AnchorOver for \(content), \
            while anchor is nil
            """)
            return
        }

        let anchorFrame = anchor.node.calculateAccumulatedFrame()
        let contentSize = content.node.calculateAccumulatedFrame().size
        let anchorPoint = CGPoint(
            x: anchorFrame.midX,
            y: anchorFrame.maxY + offsetFromAnchor + 0.5 * contentSize.height
        )

        let position = anchor.node.convert(anchorPoint, to: node)
        content.node.position = position
    }
}
