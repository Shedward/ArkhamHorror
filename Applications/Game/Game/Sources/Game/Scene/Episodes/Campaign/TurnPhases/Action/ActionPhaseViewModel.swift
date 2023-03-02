//
//  ActionPhaseEpisodeViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

final class ActionPhaseEpisodeViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: ActionPhaseEpisodeView?
    private let dependencies: Dependencies
    private let data: ActionPhaseEpisodeData

    init(data: ActionPhaseEpisodeData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
    }
}
