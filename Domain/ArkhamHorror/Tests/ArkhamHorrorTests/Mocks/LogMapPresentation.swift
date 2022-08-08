//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 09.08.2022.
//

import Prelude
import Common
@testable import ArkhamHorror

final class LogPresentation {
    var logs: [String]

    private var disposeBag: [WeakBox<AnyObject>] = []

    init() {
        logs = []
    }

    func log(_ message: String) {
        logs.append(message)
    }

    func gamePresentation(for game: Game) -> GamePresentation {
        let gamePresentation = GamePresentation()

        let mapPresentation = LogMapPresentation(presentation: self)
        gamePresentation.map = mapPresentation
        disposeBag.append(.init(mapPresentation))

        game.players().forEach { player in
            let playerPresentation = LogPlayerPresentation(playerId: player.id, presentation: self)
            gamePresentation.players[player.id] = .init(.init(wrapped: playerPresentation))
            disposeBag.append(.init(playerPresentation))
        }
        return gamePresentation
    }
}

final class LogMapPresentation: MapPresentation {
    private let presentation: LogPresentation

    init(presentation: LogPresentation) {
        self.presentation = presentation
    }

    func move(player: Player.ID, through path: [Region.ID]) {
        presentation.log("Move \(player) throught \(path)")
    }
}

final class LogPlayerPresentation: PlayerPresentation {
    private let playerId: Player.ID
    private let presentation: LogPresentation

    init(playerId: Player.ID, presentation: LogPresentation) {
        self.playerId = playerId
        self.presentation = presentation
    }

    func updateAvailableActions(_ availableActionsCount: Int) {
        presentation.log("Player \(playerId) have \(availableActionsCount) actions")
    }
}
