//
//  CampaignModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Prelude
import ArkhamHorror

protocol CampaignEpisodeProtocol: AnyObject {
    func displayBackAction(_ back: Action)
    func displayCharacters(_ characters: [CharacterCell.Data])
}

struct CampaignOutput {
    let onBack: () -> Void
}

extension Episodes {
    @MainActor
    func campaign(campaign: Campaign, output: CampaignOutput) -> GameEpisodeProtocol {
        let viewModel = CampaignViewModel(campaign: campaign, output: output)
        let episode = CampaignEpisode(viewModel: viewModel)
        return episode
    }
}
