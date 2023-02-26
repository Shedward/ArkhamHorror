//
//  MapViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

final class MapViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: MapView?
    private let dependencies: Dependencies
    private let data: MapData

    init(data: MapData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
        episode?.displayMap(data.map)
    }
}
