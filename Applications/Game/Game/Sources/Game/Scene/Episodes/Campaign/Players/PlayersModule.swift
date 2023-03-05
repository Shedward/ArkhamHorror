//
//  PlayersModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Map
import Common
import Scenes
import ArkhamHorror
import simd

protocol PlayersView: AnyObject {
    func displayPlayers(_ players: [PlayersEpisode.PlayerData])
    func movePlayer(_ id: ArkhamHorror.Player.ID, along path: [vector_float2])
}

struct PlayersData {
    let game: Game
    let mapGeometry = Gameboard.mapGeometry
}

extension Episodes {
    @MainActor
    func players(data: PlayersData) -> BaseGameEpisode {
        let viewModel = PlayersViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = PlayersEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
