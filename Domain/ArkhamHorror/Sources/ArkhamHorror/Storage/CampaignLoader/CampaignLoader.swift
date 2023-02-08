//
//  CampaignLoader.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

public protocol CampaignLoader {
    func campaignsInfo() async throws -> [CampaignInfo]
    func loadCampaign(id: Campaign.Id) async throws -> Campaign
}
