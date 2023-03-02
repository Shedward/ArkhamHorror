//
//  PlayerCell.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import HUD
import ArkhamHorror
import CoreGraphics

final class PlayerCell: View, CollectionCell {
    static let size = CGSize(width: 64, height: 64)

    let id: Player.ID
    private let portraitButton: TextureButton

    init(data: Data) {
        id = data.id
        portraitButton = TextureButton(
            texture: data.portrait.loadTexture(),
            size: Self.size,
            onTap: data.onTap
        )
        super.init()
        addChild(portraitButton)
    }
}

extension PlayerCell {
    struct Data {
        let id: Player.ID
        let portrait: ImageResource
        let onTap: () -> Void
    }
}
