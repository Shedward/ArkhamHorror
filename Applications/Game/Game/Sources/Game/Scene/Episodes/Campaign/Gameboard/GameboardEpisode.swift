//
//  GameboardEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes
import Map
import Combine

final class GameboardEpisode: GameEpisode<GameboardViewModel> {
    private var gameboard: Gameboard?

    private var cancellables: Set<AnyCancellable> = []

    override func willBegin() {
        scene?.tilt
            .sink { tiltVector in
                self.gameboard?.tilt(by: tiltVector.dy)
            }
            .store(in: &cancellables)
    }
}

extension GameboardEpisode: GameboardView {
    func displayMap(_ map: Map) {
        if let gameboard {
            removeObject(gameboard)
        }
        let gameboard = Gameboard(map: map)
        self.gameboard = gameboard
        addObject(gameboard)
    }
}
