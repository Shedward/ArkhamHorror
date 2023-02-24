//
//  CampaignViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import ArkhamHorror

final class CampaignViewModel: GameEpisodeViewModel {

    weak var episode: CampaignEpisodeProtocol?
    private let data: CampaignData

    init(data: CampaignData) {
        self.data = data
    }

    func didBegin() async {
        episode?.displayBackAction(data.onBack)
        let charactersData = data.campaign.availableCharacters.map { character in
            CharacterCell.Data(
                portrait: character.portrait
            )
        }
        episode?.displayCharacters(charactersData)
    }
}
