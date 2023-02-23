//
//  CharacterCell.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import HUD
import ArkhamHorror
import CoreGraphics

final class CharacterCell: View, CollectionCell {
    static let size = CGSize(width: 64, height: 64)

    private let portraitButton: TextureButton

    init(data: Data) {
        portraitButton = TextureButton(
            texture: data.portrait.loadTexture(),
            size: Self.size
        )
        super.init()
        addChild(portraitButton)
    }
}

extension CharacterCell {
    struct Data {
        let portrait: ImageResource
    }
}
