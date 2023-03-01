//
//  Game.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude

public final class Game {
    private(set) var campaign: Campaign
    private(set) var players: [Player]

    public init(campaign: Campaign, selectedPlayers: [Player]) {
        self.campaign = campaign
        self.players = selectedPlayers
    }

    public func endTurn() {
        players.forEach { player in
            player.refreshActions(to: campaign.info.rules.defaultCountOfActions)
        }
    }
}

