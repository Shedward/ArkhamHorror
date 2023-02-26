//
//  MapModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Map

protocol MapView: AnyObject {
    func displayMap(_ map: Map)
}

struct MapData {
    let map: Map
}

extension Episodes {
    @MainActor
    func map(data: MapData) -> BaseGameEpisode {
        let viewModel = MapViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = MapEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
