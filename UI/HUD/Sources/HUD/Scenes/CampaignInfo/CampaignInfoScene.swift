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

    private let campaignLogo = Image()
    private let backButton = TextButton(text: Localized.string("Back"))
    private let startButton = TextButton(text: Localized.string("Start"))
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

        let vStack = Stack(axis: .vertical, spacing: 16) {
            titleLabel
            descriptionText
            charactersCollection
            Stack(axis: .horizontal, spacing: 8) {
                backButton
                startButton
            }
        }

        let stack = Stack(axis: .horizontal, spacing: 16) {
            campaignLogo
            vStack
        }

        addChildView(stack)
        addChildView(errorAlert)
        self.stack = stack
    }

    func displayInitialInfo(_ info: CampaignInfoData) {
        campaignLogo.image = info.campaignLogo
        titleLabel.text = info.title
        descriptionText.text = info.description
        layout()
    }

    func displayCampaign(_ loadedData: Loading<CampaignLoadedData>) {
        errorAlert.display(loadedData.error)
        backButton.onTap = loadedData.value?.onBack
        startButton.onTap = loadedData.value?.onStart
        let portraits = loadedData.value?.portratis ?? []
        charactersCollection?.dataSource = ArrayCollectionDataSource(data: portraits).asAny()
        layout()
    }
}

extension CampaignInfoScene {
    struct CampaignInfoData {
        let campaignLogo: ImageResource
        let title: String
        let description: String
    }

    struct CampaignLoadedData {
        let portratis: [ImageResource]
        let onBack: () -> Void
        let onStart: () -> Void
    }
}
