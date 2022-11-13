//
//  CampaignStorage.swift
//  
//
//  Created by Vladislav Maltsev on 14.11.2022.
//

public protocol CampaignStorage {
    func campaigns() async throws -> [CampaignDescription]
    func loadCampaign(id: Campaign.Id) async throws -> Campaign
}
