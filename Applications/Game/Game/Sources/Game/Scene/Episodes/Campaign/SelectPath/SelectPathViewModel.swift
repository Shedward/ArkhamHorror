//
//  SelectPathEpisodeViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import simd
import Common
import Map
import Scenes
import Prelude
import DesignSystem

final class SelectPathEpisodeViewModel: GameEpisodeViewModel {
    typealias Dependencies = NoDependencies

    weak var episode: SelectPathEpisodeView?
    private let dependencies: Dependencies
    private let data: SelectPathEpisodeData
    private let mapCoordinateSystem: MapCoordinateSystem

    init(data: SelectPathEpisodeData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
        self.mapCoordinateSystem = MapCoordinateSystem(
            mapLayout: data.game.campaign.map.layout,
            mapGeometry: Gameboard.mapGeometry
        )
    }

    func didBegin() {
        let (path, points) = makeRandomPath(length: 10)
        episode?.displayPathHighlight(
            at: points,
            color: data.fromPlayer.character.tintColor.toUColor()
        )

        delayToMain(1) {
            self.data.onSelected(path)
            self.episode?.hidePathHighlight()
        }
    }

    private func makeRandomPath(length: Int) -> (path: [Region.ID], points: [vector_float2])  {
        var path: [Region.ID] = [data.fromPlayer.position]

        while path.count < length {
            guard let lastPosition = path.last else { break }
            let neighbours = data.game.campaign.map.neighbors(for: lastPosition)
            let possibleNeighbours = neighbours.filter { !path.contains($0) }
            guard let nextPosition = possibleNeighbours.randomElement() else { break }
            path.append(nextPosition)
        }

        let pathPositions = path.compactMap { regionId in
            mapCoordinateSystem.position(for: regionId)?.toVec2()
        }

        return (path, pathPositions)
    }
}
