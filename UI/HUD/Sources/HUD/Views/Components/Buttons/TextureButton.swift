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
        let shader = node.attachShader(ButtonShader.self)
        shader.setValue(size, forAttribute: .size)
        shader.setValue(borderWidth, forAttribute: .borderWidth)
        shader.setValue(node.isSelected, forAttribute: .isSelected)
        
        node.onTap = onTap
        node.onAppearanceChange = { node in
            shader.setValue(node.isSelected, forAttribute: .isSelected)
        }
        super.init(node: node)
    }
}
