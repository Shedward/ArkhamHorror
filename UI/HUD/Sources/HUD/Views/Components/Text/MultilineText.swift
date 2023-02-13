//
//  MultilineText.swift
//  
//
//  Created by Vladislav Maltsev on 14.02.2023.
//

import SpriteKit
import DesignSystem

public final class MultilineText: View {

    public var node: SKNode { label.node }

    private let label: Label
    private let designSystem = DesignSystem.default

    public var text: String? {
        didSet {
            label.text = text
        }
    }

    public init(text: String? = nil, textKind: DesignSystem.TextKind, preferredWidth: CGFloat = 256) {
        label = Label(text: text, textKind: textKind)
        label.preferredWidth = preferredWidth
        label.numberOfLines = 0
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
    }
}
