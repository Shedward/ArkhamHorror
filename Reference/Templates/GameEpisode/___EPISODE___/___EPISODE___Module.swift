//
//  ___EPISODE___Module.swift
//  
//
//  Created by Vladislav Maltsev.
//

protocol ___EPISODE___View: AnyObject {
}

struct ___EPISODE___Data {
}

extension Episodes {
    @MainActor
    func ___episode___(data: ___EPISODE___Data) -> BaseGameEpisode {
        let viewModel = ___EPISODE___ViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = ___EPISODE___Episode(episodes: self, viewModel: viewModel)
        return episode
    }
}
