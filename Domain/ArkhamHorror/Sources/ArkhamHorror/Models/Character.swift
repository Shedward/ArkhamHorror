//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Prelude

public struct Character: Codable, Identifiable {
    public enum IdTag {}
    public typealias Id = Tagged<IdTag, String>

    public let id: Id
    public let name: String
    public let portrait: ImageResource
    public let moto: String
    public let description: String
}
