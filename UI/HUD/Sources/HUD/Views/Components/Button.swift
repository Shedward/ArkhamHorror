//
//  Button.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

public class Button: View {
    public let node: SKNode

    public init(
        texture: SKTexture,
        size: CGSize = .init(width: 42, height: 42),
        borderWidth: CGFloat = 4,
        onTap: (() -> Void)?
    ) {
        let node = ButtonNode(texture: texture, size: size)
        node.isUserInteractionEnabled = true
        node.shader = ButtonShader.shader
        node.setValue(size, forAttribute: ButtonShader.Attributes.size)
        node.setValue(borderWidth, forAttribute: ButtonShader.Attributes.borderWidth)

        node.onTap = onTap
        node.onAppearanceChange = { node in
            node.setValue(node.isSelected, forAttribute: ButtonShader.Attributes.isSelected)
        }
        self.node = node
    }
}

final class ButtonNode: SKSpriteNode {
    var isSelected: Bool = false {
        didSet {
            onAppearanceChange?(self)
        }
    }

    var onTap: (() -> Void)?;
    var onAppearanceChange: ((ButtonNode) -> Void)?

#if os(macOS)
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        isSelected = true
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        isSelected = false

        if containsTouches(event) {
            onTap?()
        }
    }

    private func containsTouches(_ event: NSEvent) -> Bool {
        guard let scene else {
            return false
        }

        let touchPoint = event.location(in: scene)
        let touchedNode = scene.atPoint(touchPoint)
        return touchedNode === self
    }
#endif
}
