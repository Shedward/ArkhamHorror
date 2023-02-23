//
//  CampaignViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import ArkhamHorror

final class CampaignViewModel: GameEpisodeViewModel {

    weak var episode: CampaignEpisodeProtocol?
    private let output: CampaignOutput

    private let campaign: Campaign

    init(campaign: Campaign, output: CampaignOutput) {
        self.output = output
        self.campaign = campaign
    }

    func didBegin() async {
        episode?.displayBackAction(output.onBack)
        let charactersData = campaign.availableCharacters.map { character in
            CharacterCell.Data(
                portrait: character.portrait
            )
        }
        episode?.displayCharacters(charactersData)
    }
}
