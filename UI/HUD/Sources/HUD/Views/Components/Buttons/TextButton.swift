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
    public static let defaultSize: CGSize = .init(width: 128, height: 32)
    private let tappableNode: TappableShapeNode
    private let designSystem = DesignSystem.default

    public var onTap: (() -> Void)? {
        didSet {
            tappableNode.onTap = onTap
        }
    }

    public init(
        text: String,
        textKind: DesignSystem.TextKind = \.menu.h3,
        size: CGSize = TextButton.defaultSize,
        border: CGFloat = 4.0,
        onTap: (() -> Void)? = nil
    ) {
        tappableNode = TappableShapeNode(rect: .centeredRect(of: size))
        self.onTap = onTap
        super.init(node: tappableNode)

        tappableNode.isUserInteractionEnabled = true
        tappableNode.onTap = onTap
        tappableNode.onAppearanceChange = { [weak self] node in
            guard let self else { return }
            self.tappableNode.alpha = self.tappableNode.isSelected ? 0.8 : 1.0
        }

        tappableNode.lineWidth = border
        tappableNode.strokeColor = designSystem.text.by(textKind).color

        let textLabel = Label(text: text, textKind: textKind)
        textLabel.verticalAlignmentMode = .center
        textLabel.preferredWidth = size.width

        addChild(textLabel)
    }
}
