//
//  Label.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import DesignSystem

public final class Label: View {

    public var node: SKNode {
        labelNode
    }

    public var text: String? {
        didSet {
            labelNode.text = text
        }
    }

    public var preferredWidth: CGFloat = 0 {
        didSet {
            labelNode.preferredMaxLayoutWidth = preferredWidth
        }
    }

    public var numberOfLines: Int = 0 {
        didSet {
            labelNode.numberOfLines = numberOfLines
        }
    }

    public var lineBreakMode: NSLineBreakMode = .byTruncatingTail {
        didSet {
            labelNode.lineBreakMode = lineBreakMode
        }
    }

    public var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline {
        didSet {
            labelNode.verticalAlignmentMode = verticalAlignmentMode
        }
    }

    public var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center {
        didSet {
            labelNode.horizontalAlignmentMode = horizontalAlignmentMode
        }
    }

    private let labelNode: SKLabelNode
    private let designSystem = DesignSystem.default

    public init(text: String? = nil, textKind: DesignSystem.TextKind) {
        labelNode = SKLabelNode(text: text)
        let textStyle = designSystem.text.by(textKind)
        labelNode.fontName = textStyle.font.fontName
        labelNode.fontSize = textStyle.font.pointSize
        labelNode.fontColor = textStyle.color

        labelNode.preferredMaxLayoutWidth = preferredWidth
        labelNode.numberOfLines = numberOfLines
        labelNode.lineBreakMode = lineBreakMode
        labelNode.verticalAlignmentMode = verticalAlignmentMode
        labelNode.horizontalAlignmentMode = horizontalAlignmentMode
    }
}
