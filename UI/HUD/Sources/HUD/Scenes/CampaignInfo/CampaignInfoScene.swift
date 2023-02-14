//
//  CampaignInfoScene.swift
//  
//
//  Created by Vladislav Maltsev on 13.02.2023.
//

import SpriteKit
import Prelude
import ArkhamHorror

final class CampaignInfoScene: Scene<CampaignInfoViewModel>, CampaignInfoSceneProtocol {

    private let titleLabel = Label(textKind: \.menu.h1)
    private let descriptionText = Label.multiline(textKind: \.menu.body)
    private let errorAlert = ErrorAlert()
    private var stack: Stack?

    private var charactersCollection: Collection<ImageResource, TextureButton>?

    override func setup() {
        super.setup()

        let portraitSize = CGSize(uniform: 64)
        let cellProvider = FnCollectionCellProvider { (image: ImageResource) -> TextureButton in
            let texture = image.loadTexture()
            return TextureButton(texture: texture, size: portraitSize, onTap: nil)
        }

        let charactersCollection = Collection(
            size: .init(width: size.width, height: portraitSize.height),
            layout: CenteredRowLayout(itemSize: portraitSize, spacing: 8),
            cellProvider: cellProvider.asAny()
        )
        self.charactersCollection = charactersCollection

        let stack = Stack(axis: .vertical, spacing: 8) {
            titleLabel
            descriptionText
            charactersCollection
        }
        addChildView(stack)
        self.stack = stack
    }

    func displayInitialInfo(_ campaignInfo: CampaignInfo) {
        titleLabel.text = campaignInfo.name
        descriptionText.text = campaignInfo.description
        layout()
    }

    func displayCampaign(_ loadingCampaign: Loading<Campaign>) {
        errorAlert.display(loadingCampaign.error)

        let portraits = loadingCampaign.value?.availableCharacters.map { $0.portrait } ?? []
        charactersCollection?.dataSource = ArrayCollectionDataSource(data: portraits).asAny()
        layout()
    }
}
