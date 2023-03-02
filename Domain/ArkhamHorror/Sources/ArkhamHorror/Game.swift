//
//  Game.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude
import Combine
import Foundation

public final class Game {
    public private(set) var campaign: Campaign
    public private(set) var players: [Player]

    public init(campaign: Campaign, selectedCharacters: [Character]) {
        self.campaign = campaign
        self.players = []

        players = selectedCharacters.map { character in
            Player(
                id: .init(rawValue: UUID().uuidString),
                game: self,
                character: character,
                position: campaign.info.rules.initialPosition,
                availableActions: campaign.info.rules.defaultCountOfActions
            )
        }
    }

    public func endTurn() {
        players.forEach { player in
            player.refreshActions(to: campaign.info.rules.defaultCountOfActions)
        }
    }
}

