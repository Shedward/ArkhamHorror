//
//  Label.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import DesignSystem

public final class Label: View {
    public var text: String? {
        didSet {
            labelNode.text = text
            setNeedsLayout()
        }
    }

    public var preferredWidth: CGFloat = 0 {
        didSet {
            labelNode.preferredMaxLayoutWidth = preferredWidth
            setNeedsLayout()
        }
    }

    public var numberOfLines: Int = 0 {
        didSet {
            labelNode.numberOfLines = numberOfLines
            setNeedsLayout()
        }
    }

    public var lineBreakMode: NSLineBreakMode = .byTruncatingTail {
        didSet {
            labelNode.lineBreakMode = lineBreakMode
            setNeedsLayout()
        }
    }

    public var verticalAlignmentMode: SKLabelVerticalAlignmentMode = .baseline {
        didSet {
            labelNode.verticalAlignmentMode = verticalAlignmentMode
            setNeedsLayout()
        }
    }

    public var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode = .center {
        didSet {
            labelNode.horizontalAlignmentMode = horizontalAlignmentMode
            setNeedsLayout()
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
        super.init(node: labelNode)
    }
}
