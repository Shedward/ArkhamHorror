//
//  AlignedToTopLeft.swift
//
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SpriteKit

public final class AlignedToTopLeft: View {
    private let content: View
    private let size: CGSize
    private let insets: CGFloat

    public init(_ content: View, size: CGSize, insets: CGFloat = 16) {
        self.content = content
        self.size = size
        self.insets = insets
        super.init()
        addChild(content)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let contentSize = content.node.calculateAccumulatedFrame()
        let position = CGPoint(
            x: -0.5 * size.width + 0.5 * contentSize.width + insets,
            y: 0.5 * size.height - 0.5 * contentSize.height - insets
        )
        content.node.position = position
    }
}
