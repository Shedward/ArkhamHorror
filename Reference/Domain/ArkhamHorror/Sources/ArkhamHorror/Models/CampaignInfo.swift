//
//  CampaignInfo.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

import Foundation
import Common
import Prelude

public struct CampaignInfo: Codable, Identifiable {
    public let id: Campaign.ID
    public let name: String
    public let image: ImageResource
    public let description: String
    public let rules: CampaignRules
}
