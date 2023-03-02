//
//  CampaignDetailsModule.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

import Prelude
import ArkhamHorror
import HUD

protocol CampaignDetailsView: AnyObject {
    func displayCampaignInfo(_ info:  CampaignDetailsEpisode.CampaignInfoData)
    func displayBackAction(_ onBack: Action)
    func displayCampaignData(_ campaignData: Result<CampaignDetailsEpisode.LoadedCampaignData, Error>)
}

struct CampaignDetailsData {
    let info: CampaignInfo
    let onBack: () -> Void
    let onStartGame: (Game) -> Void
}

extension Episodes {
    @MainActor
    func campaignDetails(data: CampaignDetailsData) -> BaseGameEpisode {
        let viewModel = CampaignDetailsViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = CampaignDetailsEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
