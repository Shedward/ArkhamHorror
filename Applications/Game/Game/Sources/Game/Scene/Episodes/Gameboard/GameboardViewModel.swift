//
//  GameboardViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

final class GameboardViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: GameboardView?
    private let dependencies: Dependencies
    private let data: GameboardData

    init(data: GameboardData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
        episode?.displayMap(data.map)
    }
}
