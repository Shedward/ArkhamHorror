//
//  CampaignGameboardScene.swift
//  
//
//  Created by Vladislav Maltsev on 15.02.2023.
//

import SceneKit
import Prelude
import ArkhamHorror

final class CampaignGameboardScene: Scene<CampaignGameboardViewModel>, CampaignGameboardSceneProtocol {

    private var charactersCollection: Collection<ImageResource, TextureButton>?
    private var backButton = TextButton(text: Localized.string("Back"))

    override func setup() {
        super.setup()

        let characterSize = CGSize(uniform: 64)
        let cellProvider = FnCollectionCellProvider { (portrait: ImageResource) -> TextureButton in
            let texture = portrait.loadTexture()
            return TextureButton(texture: texture, size: characterSize, onTap: nil)
        }
        let charactersCollection = Collection(
            size: CGSize(width: size.width, height: characterSize.height),
            layout: CenteredRowLayout(itemSize: characterSize, spacing: 8),
            cellProvider: cellProvider.asAny()
        )
        self.charactersCollection = charactersCollection
        let alignedCharacters = AlignedToBottom(charactersCollection, size: size)
        addChildView(alignedCharacters)

        let alignedBackButton = AlignedToTopLeft(backButton, size: size)
        addChildView(alignedBackButton)
    }

    func display(_ data: Data) {
        charactersCollection?.dataSource = ArrayCollectionDataSource(data: data.characterPortraits).asAny()
        backButton.onTap = data.onBack
        layout()
    }
}

extension CampaignGameboardScene {
    struct Data {
        let characterPortraits: [ImageResource]
        let onBack: () -> Void
    }
}
