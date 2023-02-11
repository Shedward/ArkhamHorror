//
//  SelectCampaignViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Prelude
import ArkhamHorror

final class SelectCampaignViewModel: SceneViewModel {
    weak var scene: SelectCampaignSceneProtocol?

    private let campaignLoader: CampaignLoader
    private let onCampaignSelected: (CampaignInfo) -> Void

    init(campaignLoader: CampaignLoader, onCampaignSelected: @escaping (CampaignInfo) -> Void) {
        self.campaignLoader = campaignLoader
        self.onCampaignSelected = onCampaignSelected
    }

    func sceneDidLoad() {
        loadCampaign()
    }

    private func loadCampaign() {
        Task {
            scene?.displayCampaigns(.loading)
            let campaignsResult = await Loading.async { try await campaignLoader.campaignsInfo() }
            scene?.displayCampaigns(campaignsResult)
        }
    }
}
