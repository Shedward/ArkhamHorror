//
//  PlayersViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2023.
//

import Prelude
import Common
import ArkhamHorror
import Map
import HSLuvSwift
import DesignSystem

final class PlayersViewModel: GameEpisodeViewModel {
    typealias Dependencies = NoDependencies

    weak var episode: PlayersView?
    private let dependencies: Dependencies
    private let data: PlayersData

    private let mapCoordinateSystem: MapCoordinateSystem
    private var subscriptions = SubscriptionsBag()
    private let logger = Logger()

    init(data: PlayersData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
        self.mapCoordinateSystem = MapCoordinateSystem(
            mapLayout: data.game.campaign.map.layout,
            mapGeometry: data.mapGeometry
        )
    }

    func didBegin() async {
        let playersData = data.game.players.map { player -> PlayersEpisode.PlayerData in
            let playerId = player.id

            player.movedEvents
                .sink { [weak self] event in
                    self?.movePlayer(playerId, path: event.path)
                }
                .store(in: &subscriptions)

            let playerData = PlayersEpisode.PlayerData(
                id: playerId,
                color: UColor(randomForHashOf: playerId),
                position: mapCoordinateSystem.position(for: player.position)?.toVec2() ?? .zero
            )
            return playerData
        }
        episode?.displayPlayers(playersData)
    }

    private func movePlayer(_ playerId: Player.ID, path: [Region.ID]) {
        let pointsPath = path.compactMap {
            mapCoordinateSystem.position(for: $0)?.toVec2()
        }

        episode?.movePlayer(playerId, along: pointsPath)
    }
}
