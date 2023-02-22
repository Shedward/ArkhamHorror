//
//  CampaignDetailsEpisode.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

import DesignSystem
import ArkhamHorror
import HUD
import Prelude

final class CampaignDetailsEpisode: GameEpisode<CampaignDetailsViewModel>, CampaignDetailsEpisodeProtocol {

    private var backButton: TextButton?
    private var campaignLogoImage: Image?
    private var titleLabel: Label?
    private var descriptionLabel: Label?

    override func willBegin() async {

        let backButton = TextButton(text: Localized.string("Back"))
        self.backButton = backButton
        let backContainer = AlignedToTopLeft(backButton, size: overlaySize)
        await addView(backContainer)

        let titleLabel = Label(textKind: \.menu.h1)
        self.titleLabel = titleLabel

        let campaignLogoImage = Image()
        self.campaignLogoImage = campaignLogoImage

        let descriptionLabel = Label.multiline(textKind: \.menu.body)
        self.descriptionLabel = descriptionLabel

        let content = Stack(axis: .horizontal, spacing: 16) {
            campaignLogoImage
            Stack(axis: .vertical, spacing: 8) {
                titleLabel
                descriptionLabel
            }
        }

        await addView(content)
    }

    func displayCampaignInfo(_ info: CampaignInfoData) {
        titleLabel?.text = info.title
        campaignLogoImage?.image = info.image
        descriptionLabel?.text = info.description
        layout()
    }

    func displayBackAction(_ action: Action) {
        backButton?.onTap = action
    }

    func displayCharacters(_ loading: Loading<[CharacterData]>) {
        layout()
    }
}

extension CampaignDetailsEpisode {
    struct CampaignInfoData {
        let title: String
        let description: String
        let image: ImageResource
    }

    struct CharacterData {
        let name: String
        let portrait: ImageResource
    }
}
