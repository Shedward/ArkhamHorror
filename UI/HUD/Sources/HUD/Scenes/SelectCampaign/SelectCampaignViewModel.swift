//
//  SelectCampaignViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Prelude
import ArkhamHorror

final class SelectCampaignViewModel: SceneViewModel {
    typealias Dependencies =
        CampaignLoaderDependency

    weak var scene: SelectCampaignSceneProtocol?

    private let dependencies: Dependencies
    private let output: SelectCampaignOutput
    private let logger = Logger()

    init(dependencies: Dependencies, output: SelectCampaignOutput) {
        self.dependencies = dependencies
        self.output = output
    }

    func sceneDidLoad() {
        loadCampaign()
    }

    private func loadCampaign() {
        Task {
            scene?.displayCampaigns(.loading)
            let campaignsResult = await Loading.async {
                try await self.dependencies.campaignLoader.campaignsInfo()
            }
            let campaignsData = campaignsResult.map {
                $0.map { info in
                    CampaignCell.Data(
                        name: info.name,
                        image: info.image,
                        onTap: { [output] in output.onCampaignSelected(info) }
                    )
                }
            }
            scene?.displayCampaigns(campaignsData)
        }
    }
}
