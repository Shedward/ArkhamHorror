//
//  PlayersModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

protocol PlayersView: AnyObject {
}

struct PlayersData {
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
