//
//  CampaignCell.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import ArkhamHorror
import DesignSystem

final public class CampaignCell: View, CollectionCell {
    public static let size: CGSize = CGSize(width: 256, height: 256 + 16 + 16)

    public init(data: Data) {
        super.init()

        let buttonTexture = data.image.loadTexture()
        let stack = Stack(axis: .vertical, spacing: 16) {
            TextureButton(
                texture: buttonTexture,
                size: CGSize(uniform: CampaignCell.size.width),
                borderWidth: 8,
                onTap: data.onTap
            )
            Label(text: data.name, textKind: \.menu.h2)
        }
        addChild(stack)
    }
}

extension CampaignCell {
    public struct Data {
        public var name: String
        public var image: ArkhamHorror.ImageResource
        public var onTap: () -> Void

        public init(name: String, image: ArkhamHorror.ImageResource, onTap: @escaping () -> Void) {
            self.name = name
            self.image = image
            self.onTap = onTap
        }
    }
}
