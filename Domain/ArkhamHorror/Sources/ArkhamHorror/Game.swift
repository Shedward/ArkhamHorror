//
//  Game.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude

public class Game {
    public struct State {
        var campaignId: Campaign.Id
        var players: [Player]
    }

    private var state: State
    var presentation: GamePresentation = .init()

    init(initialState: State) {
        self.state = initialState
    }

    func players() -> [Player] {
        state.players
    }

    func movePlayer(_ playerId: Player.ID, path regionIds: [Region.ID]) {
        guard
            var player = state.players[id: playerId],
            player.availableActions > 0,
            let finalDestination = regionIds.last
        else { return }

        player.position = finalDestination
        player.availableActions -= 1

        state.players[id: playerId] = player

        presentation.map?.move(player: playerId, through: [player.position] + regionIds)
        presentation.players[playerId]?.value?.updateAvailableActions(player.availableActions)
    }

    func endTurn() {
        state.players.mutatingForEach { player in
            player.availableActions = 2
            presentation.players[player.id]?.value?.updateAvailableActions(player.availableActions)
        }
    }
}
