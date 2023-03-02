//
//  GameboardEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes
import Map

final class GameboardEpisode: GameEpisode<GameboardViewModel> {
    private var gameboard: Gameboard?
}

extension GameboardEpisode: GameboardView {
    func displayMap(_ map: Map) {
        if let gameboard {
            removeObject(gameboard)
        }
        let gameboard = Gameboard(map: map)
        addObject(gameboard)
    }
}
