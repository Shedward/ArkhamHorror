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
            let campaignInfoData = CampaignInfoScene.CampaignInfoData(
                campaignLogo: campaignInfo.image,
                title: campaignInfo.name,
                description: campaignInfo.description
            )
            scene?.displayInitialInfo(campaignInfoData)

            scene?.displayCampaign(.loading)
            let campaign = await Loading.async {
                try await dependencies.campaignLoader.loadCampaign(id: campaignInfo.id)
            }

            let campaignData = campaign.map { campaign in
                CampaignInfoScene.CampaignLoadedData(
                    portratis: campaign.availableCharacters.map(\.portrait),
                    onBack: { [output] in
                        output.onBack()
                    },
                    onStart: { [output] in
                        output.onStartCampaign(campaign)
                    }
                )
            }
            scene?.displayCampaign(campaignData)
        }
    }
}
