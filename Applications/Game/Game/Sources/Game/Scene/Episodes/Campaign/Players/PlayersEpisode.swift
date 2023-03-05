//
//  PlayersEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes
import ArkhamHorror
import DesignSystem
import simd

final class PlayersEpisode: GameEpisode<PlayersViewModel> {
    private var playerObjects: [Scenes.Player] = []
}

extension PlayersEpisode: PlayersView {
    func displayPlayers(_ players: [PlayerData]) {
        playerObjects = players.map { playerData in
            let player = Scenes.Player(id: playerData.id, color: playerData.color)
            addObject(player)
            player.moveTo(playerData.position, animated: false)
            return player
        }
    }

    func movePlayer(_ id: ArkhamHorror.Player.ID, along path: [vector_float2]) {
        for pathPoint in path {
            playerObjects[id: id]?.moveTo(pathPoint, animated: true)
        }
    }
}

extension PlayersEpisode {
    struct PlayerData {
        let id: ArkhamHorror.Player.ID
        let color: UColor
        let position: vector_float2
    }
}
