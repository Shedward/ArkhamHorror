//
//  TextButton.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import Prelude
import DesignSystem

public final class TextButton: View {
    static let defaultSize: CGSize = .init(width: 128, height: 32)
    private let designSystem = DesignSystem.default

    init(
        text: String,
        textKind: DesignSystem.TextKind,
        size: CGSize = TextButton.defaultSize,
        border: CGFloat = 4.0,
        onTap: @escaping () -> Void
    ) {
        let node = TappableShapeNode(rect: .centeredRect(of: size))
        node.isUserInteractionEnabled = true
        node.onTap = onTap
        node.onAppearanceChange = { node in
            node.alpha = node.isSelected ? 0.8 : 1.0
        }

        node.lineWidth = border
        node.strokeColor = designSystem.text.by(textKind).color

        let textLabel = Label(text: text, textKind: textKind)
        textLabel.verticalAlignmentMode = .center
        textLabel.preferredWidth = size.width

        super.init(node: node)
        addChild(textLabel)
    }
}
