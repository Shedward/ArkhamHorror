//
//  CampaignModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Prelude
import ArkhamHorror

protocol CampaignView: AnyObject {
    func displayBackAction(_ back: Action)
    func displayCharacters(_ characters: [CharacterCell.Data])

    func presentGameboard(_ data: GameboardData)
    func presentActions(_ data: SelectActionData)
}

struct CampaignData {
    let campaign: Campaign
    let onBack: () -> Void
}

extension Episodes {
    @MainActor
    func campaign(data: CampaignData) -> BaseGameEpisode {
        let viewModel = CampaignViewModel(data: data)
        let episode = CampaignEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
