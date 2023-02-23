//
//  CampaignDetailsModule.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

import Prelude
import ArkhamHorror
import HUD

protocol CampaignDetailsEpisodeProtocol: AnyObject {
    func displayCampaignInfo(_ info:  CampaignDetailsEpisode.CampaignInfoData)
    func displayBackAction(_ onBack: Action)
    func displayCampaignData(_ campaignData: Result<CampaignDetailsEpisode.LoadedCampaignData, Error>)
}

struct CampaignDetailsOutput {
    let onBack: () -> Void
    let onStartCampaign: (Campaign) -> Void
}

extension Episodes {
    @MainActor
    func campaignDetails(info: CampaignInfo, output: CampaignDetailsOutput) -> GameEpisodeProtocol {
        let viewModel = CampaignDetailsViewModel(
            info: info,
            dependencies: dependencies,
            output: output
        )
        let episode = CampaignDetailsEpisode(viewModel: viewModel)
        return episode
    }
}
