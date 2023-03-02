//
//  ActionPhaseEpisodeModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

protocol ActionPhaseEpisodeView: AnyObject {
}

struct ActionPhaseEpisodeData {
}

extension Episodes {
    @MainActor
    func ActionPhaseEpisode(data: ActionPhaseEpisodeData) -> BaseGameEpisode {
        let viewModel = ActionPhaseEpisodeViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = ActionPhaseEpisodeEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
