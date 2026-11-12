//
//  Image.swift
//  
//
//  Created by Vladislav Maltsev on 15.02.2023.
//

import SpriteKit
import ArkhamHorror

public class Image: View {

    public var image: ArkhamHorror.ImageResource? {
        didSet {
            updateTexture()
        }
    }

    private let spriteNode = SKSpriteNode()

    public init(image: ArkhamHorror.ImageResource? = nil, size: CGSize = .init(width: 256, height: 256)) {
        self.spriteNode.size = size
        self.image = image
        super.init(node: spriteNode)
        updateTexture()
    }

    private func updateTexture() {
        spriteNode.texture = image?.loadTexture()
    }
}
