//
//  Campaign.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude

public struct Campaign: Codable, Identifiable {
    public enum IdTag {}
    public typealias Id = Tagged<IdTag, String>

    public struct Rules: Codable {
        let initialPosition: Region.ID
        let defaultCountOfActions: Int
    }

    public let id: Id
    public let name: String
    public let description: String
    public let rules: Rules

    public let availableCharacters: [Character]
}

public struct CampaignDescription: Codable {
    public let id: Campaign.Id
    public let name: String
    public let description: String

    public init(campaign: Campaign) {
        self.id = campaign.id
        self.name = campaign.description
        self.description = campaign.description
    }
}
