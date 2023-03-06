//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Prelude

public struct Character: Codable, Identifiable {
    public enum IdTag {}
    public typealias ID = Tagged<IdTag, String>

    public let id: ID
    public let name: String
    public let portrait: ImageResource
    public let moto: String
    public let description: String
    public let tintColor: Color
    public let rules: CharacterRules


    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Character.ID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.portrait = try container.decode(ImageResource.self, forKey: .portrait)
        self.moto = try container.decode(String.self, forKey: .moto)
        self.description = try container.decode(String.self, forKey: .description)
        self.tintColor = try container.decode(Color.self, forKey: .tintColor)
        self.rules = (try? container.decode(CharacterRules.self, forKey: .rules)) ?? CharacterRules.default
    }
}
