//
//  CampaignViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import ArkhamHorror

final class CampaignViewModel: GameEpisodeViewModel {

    weak var episode: CampaignView?
    private let data: CampaignData

    init(data: CampaignData) {
        self.data = data
    }

    func didBegin() async {
        episode?.displayBackAction(data.onBack)
        let charactersData = data.campaign.availableCharacters.map { character in
            CharacterCell.Data(
                id: character.id,
                portrait: character.portrait,
                onTap: { [weak self] in
                    let data = SelectActionData(id: character.id)
                    self?.episode?.openActions(data)
                }
            )
        }
        episode?.displayCharacters(charactersData)
        episode?.openMap(.init(map: data.campaign.map))
    }
}
