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
    private var startButton: TextButton?
    private var errorAlert: ErrorAlert?

    override func willBegin() {
        let backButton = TextButton(text: Localized.string("Back"))
        self.backButton = backButton
        let backContainer = AlignedToTopLeft(backButton, size: overlaySize)
        addView(backContainer)

        let titleLabel = Label(textKind: \.menu.h1)
        self.titleLabel = titleLabel

        let campaignLogoImage = Image()
        self.campaignLogoImage = campaignLogoImage

        let descriptionLabel = Label.multiline(textKind: \.menu.body)
        self.descriptionLabel = descriptionLabel

        let startButton = TextButton(text: Localized.string("Start"))
        self.startButton = startButton

        let content = Stack(axis: .horizontal, spacing: 16) {
            campaignLogoImage
            Stack(axis: .vertical, spacing: 8) {
                titleLabel
                descriptionLabel
                startButton
            }
        }
        addView(content)

        let errorAlert = ErrorAlert()
        self.errorAlert = errorAlert
        addView(errorAlert)
    }

    func displayCampaignInfo(_ info: CampaignInfoData) {
        titleLabel?.text = info.title
        campaignLogoImage?.image = info.image
        descriptionLabel?.text = info.description
        layout()
    }

    func displayBackAction(_ onBack: Action) {
        backButton?.onTap = onBack
    }

    func displayCampaignData(_ campaignData: Result<LoadedCampaignData, Error>) {
        switch campaignData {
        case .success(let data):
            startButton?.onTap = data.onStart
            errorAlert?.display(nil)
        case .failure(let error):
            startButton?.onTap = nil
            errorAlert?.display(error)
        }
    }

    func displayStartCampaignAction(_ onStartCampaign: Action) {
        startButton?.onTap = onStartCampaign
    }
}

extension CampaignDetailsEpisode {
    struct CampaignInfoData {
        let title: String
        let description: String
        let image: ImageResource
    }

    struct LoadedCampaignData {
        let onStart: () -> Void
    }
}
