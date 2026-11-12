//
//  Campaign.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common
import Prelude
import Map

public struct Campaign: Identifiable {
    public enum IdTag {}
    public typealias Id = Tagged<IdTag, String>

    public let id: Id

    public let info: CampaignInfo
    public let availableCharacters: [Character]
    public let map: Map

    public init(
        info: CampaignInfo,
        availableCharacters: [Character],
        map: Map
    ) {
        self.id = info.id
        self.info = info
        self.availableCharacters = availableCharacters
        self.map = map
    }
}
