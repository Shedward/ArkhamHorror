//
//  GameboardModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Map

protocol GameboardView: AnyObject {
    func displayMap(_ map: Map)
}

struct GameboardData {
    let map: Map
}

extension Episodes {
    @MainActor
    func map(data: GameboardData) -> BaseGameEpisode {
        let viewModel = GameboardViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = GameboardEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
