//
//  SelectCampaignModule.swift
//  
//
//  Created by Vladislav Maltsev on 21.02.2023.
//

import Prelude
import ArkhamHorror
import HUD

protocol SelectCampaignEpisodeProtocol: AnyObject {
    func displayCampaigns(_ loadingCampaigns: Loading<[CampaignCell.Data]>)
}

struct SelectCampaignOutput {
    let didSelectCampaign: (CampaignInfo) -> Void
}

extension Episodes {
    @MainActor
    func selectCampaign(output: SelectCampaignOutput) -> BaseGameEpisode {
        let viewModel = SelectCampaignViewModel(dependencies: dependencies, output: output)
        let episode = SelectCampaignEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
