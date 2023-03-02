//
//  PlayersEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes

final class PlayersEpisode: GameEpisode<PlayersViewModel> {
    private var playerObjects: [Scenes.Player] = []

    override func willBegin() {
    }
}

extension PlayersEpisode: PlayersView {
}
