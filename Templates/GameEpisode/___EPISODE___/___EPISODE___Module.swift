//
//  ___EPISODE___Module.swift
//  
//
//  Created by Vladislav Maltsev.
//

protocol ___EPISODE___EpisodeProtocol: AnyObject {
}

struct ___EPISODE___Output {
}

extension Episodes {
    @MainActor
    func ___episode___(output: ___EPISODE___Output) -> GameEpisodeProtocol {
        let viewModel = ___EPISODE___ViewModel(
            dependencies: dependencies,
            output: output
        )
        let episode = ___EPISODE___Episode(viewModel: viewModel)
        return episode
    }
}
