//
//  Label.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import DesignSystem

struct Label: View {
    let node: SKNode

    private let designSystem = DesignSystem.default

    init(text: String, textKind: DesignSystem.TextKind) {
        let node = SKLabelNode(text: text)
        let textStyle = designSystem.text.by(textKind)
        node.fontName = textStyle.font.fontName
        node.fontSize = textStyle.font.pointSize
        node.fontColor = textStyle.color
        self.node = node
    }
}
