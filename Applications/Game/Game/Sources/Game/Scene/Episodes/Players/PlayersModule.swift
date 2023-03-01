//
//  PlayersModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Map
import Common
import ArkhamHorror

protocol PlayersView: AnyObject {
}

struct PlayersData {
    let players: [Player]
}

extension Episodes {
    @MainActor
    func Players(data: PlayersData) -> BaseGameEpisode {
        let viewModel = PlayersViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = PlayersEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
