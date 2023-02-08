//
//  Campaign.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude

public struct Campaign: Identifiable {
    public enum IdTag {}
    public typealias Id = Tagged<IdTag, String>

    public let id: Id

    public let info: CampaignInfo
    public let availableCharacters: [Character]

    public init(info: CampaignInfo, availableCharacters: [Character]) {
        self.id = info.id
        self.info = info
        self.availableCharacters = availableCharacters
    }
}
