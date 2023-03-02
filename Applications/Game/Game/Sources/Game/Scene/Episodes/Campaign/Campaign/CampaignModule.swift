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
    func displayCharacters(_ characters: [PlayerCell.Data])

    func presentGameboard(_ data: GameboardData)
    func presentPlayers(_ data: PlayersData)
    func presentActions(_ data: SelectActionData)
}

struct CampaignData {
    let game: Game
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
