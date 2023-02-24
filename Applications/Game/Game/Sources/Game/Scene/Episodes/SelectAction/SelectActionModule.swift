//
//  SelectActionModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

protocol SelectActionEpisodeProtocol: AnyObject {
}

struct SelectActionData {
}

extension Episodes {
    @MainActor
    func selectAction(data: SelectActionData) -> BaseGameEpisode {
        let viewModel = SelectActionViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = SelectActionEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
