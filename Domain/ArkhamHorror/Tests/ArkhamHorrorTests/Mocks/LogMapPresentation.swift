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

    private var disposeBag: [AnyObject] = []

    init() {
        logs = []
    }

    func log(_ message: String) {
        logs.append(message)
    }

    func gamePresentation(for game: Game) -> Presentation {
        let gamePresentation = Presentation()

        let mapPresentation = LogMapPresentation(presentation: self)
        gamePresentation.map = mapPresentation
        disposeBag.append(mapPresentation)

        game.players().forEach { player in
            let playerPresentation = LogPlayerPresentation(playerId: player.id, presentation: self)
            let anyPlayerPresentation = AnyPlayerPresentation(wrapped: playerPresentation)
            gamePresentation.players[player.id] = .init(anyPlayerPresentation)
            disposeBag.append(anyPlayerPresentation)
        }
        return gamePresentation
    }
}

final class LogMapPresentation: MapPresentation {
    private weak var presentation: LogPresentation?

    init(presentation: LogPresentation) {
        self.presentation = presentation
    }

    func move(player: Player.ID, through path: [Region.ID]) {
        let pathDescription = path.map(\.rawValue)
            .joined(separator: ", ")
        presentation?.log("Move \(player.rawValue) throught \(pathDescription)")
    }
}

final class LogPlayerPresentation: PlayerPresentation {
    private let playerId: Player.ID
    private weak var presentation: LogPresentation?

    init(playerId: Player.ID, presentation: LogPresentation) {
        self.playerId = playerId
        self.presentation = presentation
    }

    func updateAvailableActions(_ availableActionsCount: Int) {
        presentation?.log("Player \(playerId.rawValue) have \(availableActionsCount) actions")
    }
}
