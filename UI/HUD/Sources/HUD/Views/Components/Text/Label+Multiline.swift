//
//  MultilineText.swift
//  
//
//  Created by Vladislav Maltsev on 14.02.2023.
//

import SpriteKit
import DesignSystem

extension Label {
    public static func multiline(
        text: String? = nil,
        textKind: DesignSystem.TextKind,
        preferredWidth: CGFloat = 256
    ) -> Label {
        let label = Label(text: text, textKind: textKind)
        label.preferredWidth = preferredWidth
        label.numberOfLines = 0
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }
}
