//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Prelude
import Common

public struct Player: Identifiable {
    public enum IdTag {}
    public typealias ID = Tagged<IdTag, String>

    public let id: ID
    let characterId: Character.Id
    var position: Region.ID
    var availableActions: Int
}
