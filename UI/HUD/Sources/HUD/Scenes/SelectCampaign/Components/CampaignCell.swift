//
//  CampaignCell.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import ArkhamHorror
import DesignSystem

final class CampaignCell: View {
    static let size: CGSize = CGSize(width: 256, height: 256 + 16 + 16)

    init(data: Data) {
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
    struct Data {
        let name: String
        let image: ImageResource
        let onTap: () -> Void
    }
}
