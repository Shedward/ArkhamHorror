//
//  InMemoryCampaignLoader.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

import Foundation
import Prelude

public final class InMemoryCampaignLoader: CampaignLoader {
    public var campaigns: [Campaign]

    public init(campaigns: [Campaign] = []) {
        self.campaigns = campaigns
    }

    public func campaignsInfo() async throws -> [CampaignInfo] {
        campaigns.map(\.info)
    }

    public func loadCampaign(id: Campaign.Id) async throws -> Campaign {
        guard let campaign = campaigns.first(byId: id) else {
            throw AppError("Campaign \(id) not found")
        }
        return campaign
    }
}
