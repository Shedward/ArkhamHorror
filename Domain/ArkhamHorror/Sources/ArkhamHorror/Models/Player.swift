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
    public let characterId: Character.Id
    public private(set) var position: Region.ID
    public private(set) var availableActions: Int {
        didSet {
            events.actionsCountChangedSubject.value = availableActions
        }
    }

    public let events = Events()

    init(id: ID, characterId: Character.Id, position: Region.ID, availableActions: Int) {
        self.id = id
        self.characterId = characterId
        self.position = position
        self.availableActions = availableActions
        events.actionsCountChangedSubject.value = availableActions
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
        events.movedSubject.send(.init(path: path))
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

    public struct Events {
        public struct Moved {
            public let path: [Region.ID]
        }

        fileprivate let movedSubject = EventSubject<Moved>()
        var moved: EventPublisher<Moved> {
            movedSubject.eraseToAnyPublisher()
        }

        fileprivate let actionsCountChangedSubject = ValueSubject(0)
        var actionsCountChanged: ValuePublisher<Int> {
            actionsCountChangedSubject.eraseToAnyPublisher()
        }
    }
}
