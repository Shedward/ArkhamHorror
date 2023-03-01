//
//  PlayersViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

final class PlayersViewModel: GameEpisodeViewModel {
    typealias Dependencies = NoDependencies

    weak var episode: PlayersView?
    private let dependencies: Dependencies
    private let data: PlayersData

    init(data: PlayersData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }
}
