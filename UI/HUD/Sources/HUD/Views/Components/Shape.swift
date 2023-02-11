//
//  Shape.swift
//  
//
//  Created by Vladislav Maltsev on 12.02.2023.
//

import SpriteKit
import DesignSystem

public final class Shape: View {
    public var node: SKNode { shapeNode }
    private let shapeNode: SKShapeNode = .init()

    private let designSystem = DesignSystem.default

    var path: CGPath? {
        get {
            shapeNode.path
        }
        set {
            shapeNode.path = newValue
        }
    }

    init(
        path: CGPath? = nil,
        stroke: DesignSystem.ColorKind,
        fill: DesignSystem.ColorKind,
        borderWidth: CGFloat = 4.0
    ) {
        shapeNode.fillColor = designSystem.color.by(fill)
        shapeNode.strokeColor = designSystem.color.by(stroke)
        shapeNode.lineWidth = borderWidth
    }
}
