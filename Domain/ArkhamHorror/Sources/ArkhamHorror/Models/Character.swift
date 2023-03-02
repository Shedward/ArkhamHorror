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

    public let rules: CharacterRules


    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Character.Id.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.portrait = try container.decode(ImageResource.self, forKey: .portrait)
        self.moto = try container.decode(String.self, forKey: .moto)
        self.description = try container.decode(String.self, forKey: .description)
        self.rules = (try? container.decode(CharacterRules.self, forKey: .rules)) ?? CharacterRules.default
    }
}
