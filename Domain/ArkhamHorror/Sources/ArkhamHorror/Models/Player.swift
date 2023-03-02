//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Prelude
import Common
import Foundation
import Combine

public class Player: Identifiable {
    public let id: ID
    public let character: Character
    public private(set) weak var game: Game?

    @Published
    public private(set) var position: Region.ID
    @Published
    public private(set) var availableActions: Int
    @Published
    public private(set) var availableMovePoints: Int

    private let movedSubject = EventSubject<Events.Moved>()
    public var moved: EventPublisher<Events.Moved> {
        movedSubject.eraseToAnyPublisher()
    }

    init(id: ID, game: Game, character: Character, position: Region.ID, availableActions: Int) {
        self.id = id
        self.game = game
        self.character = character
        self.position = position
        self.availableActions = availableActions
        self.availableMovePoints = character.rules.availableMovePoints
    }

    public func move(to region: Region.ID) throws {
        try move(path: [region])
    }

    public func move(path: [Region.ID]) throws {
        guard availableActions > 0 else {
            throw AppError("Can't move. There are no more available actions.")
        }

        guard let pathEnd = path.last else {
            throw AppError("Can't move. Path is empty.")
        }
        try spendAction()
        position = pathEnd
        movedSubject.send(.init(path: path))
    }

    public func spendAction() throws {
        guard availableActions > 0 else {
            throw AppError("Can't spend action. There is no actions left")
        }
        availableActions -= 1
    }

    public func refreshActions(to actionsCount: Int) {
        availableActions = actionsCount
    }
}

extension Player {
    public enum IdTag {}
    public typealias ID = Tagged<IdTag, String>

    public enum Events {
        public struct Moved {
            public let path: [Region.ID]
        }
    }
}
