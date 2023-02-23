//
//  CampaignDetailsViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

import ArkhamHorror
import Prelude

final class CampaignDetailsViewModel: GameEpisodeViewModel {
    typealias Dependencies = CampaignLoaderDependency

    weak var episode: CampaignDetailsEpisodeProtocol?
    private let dependencies: Dependencies
    private let output: CampaignDetailsOutput

    private let info: CampaignInfo

    init(info: CampaignInfo, dependencies: Dependencies, output: CampaignDetailsOutput) {
        self.info = info
        self.dependencies = dependencies
        self.output = output
    }

    func didBegin() async {
        episode?.displayBackAction(output.onBack)

        let infoData = CampaignDetailsEpisode.CampaignInfoData(
            title: info.name,
            description: info.description,
            image: info.image
        )
        episode?.displayCampaignInfo(infoData)
        let campaignResult = await asyncResult {
            try await dependencies.campaignLoader.loadCampaign(id: info.id)
        }

        let campaignData = campaignResult.map { campaign in
            CampaignDetailsEpisode.LoadedCampaignData(
                onStart: { [output] in
                    output.onStartCampaign(campaign)
                }
            )
        }
        episode?.displayCampaignData(campaignData)
    }
}
