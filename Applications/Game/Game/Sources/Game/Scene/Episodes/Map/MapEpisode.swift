//
//  MapEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes
import Map

final class MapEpisode: GameEpisode<MapViewModel> {

    private var gameboard: Gameboard?
}

extension MapEpisode: MapView {
    func displayMap(_ map: Map) {
        if let gameboard {
            removeObject(gameboard)
        }
        let gameboard = Gameboard(map: map)
        addObject(gameboard)
    }
}
