//
//  TextureButton.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

public final class TextureButton: View {
    public init(
        texture: SKTexture,
        size: CGSize = .init(width: 42, height: 42),
        borderWidth: CGFloat = 4,
        onTap: (() -> Void)? = nil
    ) {
        let node = TappableSpriteNode(texture: texture, size: size)
        node.isUserInteractionEnabled = true
        node.shader = ButtonShader.shader
        node.setValue(size, forAttribute: ButtonShader.Attributes.size)
        node.setValue(borderWidth, forAttribute: ButtonShader.Attributes.borderWidth)
        node.setValue(node.isSelected, forAttribute: ButtonShader.Attributes.isSelected)
        
        node.onTap = onTap
        node.onAppearanceChange = { node in
            node.setValue(node.isSelected, forAttribute: ButtonShader.Attributes.isSelected)
        }
        super.init(node: node)
    }
}
