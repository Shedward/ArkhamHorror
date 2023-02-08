//
//  InMemoryCampaignLoader.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

import Foundation

public enum InMemoryCampaignLoaderError: Error {
    case notFound
}

public final class InMemoryCampaignLoader: CampaignLoader {
    public var campaigns: [Campaign]

    public init(campaigns: [Campaign] = []) {
        self.campaigns = campaigns
    }

    public func campaigns() async throws -> [CampaignDescription] {
        campaigns.map(CampaignDescription.init(campaign:))
    }

    public func loadCampaign(id: Campaign.Id) async throws -> Campaign {
        guard let campaign = campaigns.first(byId: id) else {
            throw InMemoryCampaignLoaderError.notFound
        }
        return campaign
    }
}
