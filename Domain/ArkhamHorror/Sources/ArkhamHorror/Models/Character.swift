//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Prelude

public struct Character: Codable {
    enum IdTag {}
    typealias Id = Tagged<IdTag, String>

    let id: Id
    let name: String
    let portrait: ResourceLink
    let moto: String
    let description: String
}
