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
        let charactersData = data.game.players.map { player in
            PlayerCell.Data(
                id: player.id,
                portrait: player.character.portrait,
                onTap: { [weak self] in
                    let data = SelectActionData(player: player)
                    self?.episode?.presentActions(data)
                }
            )
        }
        episode?.displayCharacters(charactersData)
        episode?.presentGameboard(.init(map: data.game.campaign.map))
        episode?.presentPlayers(.init(game: data.game))
    }
}
