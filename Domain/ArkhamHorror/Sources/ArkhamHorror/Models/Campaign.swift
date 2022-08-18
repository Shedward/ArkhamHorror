//
//  Campaign.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude

public struct Campaign: Codable {
    enum IdTag {}
    typealias Id = Tagged<IdTag, String>

    public struct Rules: Codable {
        let initialPosition: Region.ID
        let defaultCountOfActions: Int
    }

    let id: Id
    let name: String
    let description: String
    let rules: Rules

    let availableCharacters: [Character]
}
