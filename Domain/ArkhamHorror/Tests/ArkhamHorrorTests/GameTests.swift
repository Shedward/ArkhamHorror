//
//  GameTests.swift
//  
//
//  Created by Vladislav Maltsev on 09.08.2022.
//

import XCTest
@testable import ArkhamHorror

final class GameTests: XCTestCase {
    func testUserMoving() throws {
        let alice = Player(
            id: "alice",
            characterId: "alice",
            position: "p1",
            availableActions: 2
        )

        let bob = Player(
            id: "bob",
            characterId: "bob",
            position: "p1",
            availableActions: 2
        )

        let initialState = Game.State(
            campaignId: "test_campaign",
            players: [alice, bob]
        )

        let game = Game(initialState: initialState)

        let logPresentation = LogPresentation()
        game.presentation = logPresentation.gamePresentation(for: game)
        XCTAssertEqual(logPresentation.logs, [])

        game.movePlayer(bob.id, path: ["p3"])
        game.movePlayer(bob.id, path: ["p4"])
        game.movePlayer(bob.id, path: ["p5"])

        XCTAssertEqual(
            logPresentation.logs,
            [
                "Move bob throught p1, p3",
                "Player bob have 1 actions",
                "Move bob throught p3, p4",
                "Player bob have 0 actions"
            ]
        )

        game.endTurn()
    }
}
