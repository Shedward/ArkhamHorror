//
//  CampaignInfoViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 13.02.2023.
//

import Prelude
import ArkhamHorror

final class CampaignInfoViewModel: SceneViewModel {
    public typealias Dependencies =
        CampaignLoaderDependency

    weak var scene: CampaignInfoSceneProtocol?

    private let campaignInfo: CampaignInfo
    private let dependencies: Dependencies
    private let output: CampaignInfoOutput

    init(
        campaignInfo: CampaignInfo,
        dependencies: Dependencies,
        output: CampaignInfoOutput
    ) {
        self.campaignInfo = campaignInfo
        self.dependencies = dependencies
        self.output = output
    }

    func sceneDidLoad() {
        Task {
            scene?.displayInitialInfo(campaignInfo)
            scene?.displayCampaign(.loading)
            let campaign = await Loading.async {
                try await dependencies.campaignLoader.loadCampaign(id: campaignInfo.id)
            }
            scene?.displayCampaign(campaign)
        }
    }
}
