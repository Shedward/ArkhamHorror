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

    weak var episode: CampaignDetailsView?
    private let dependencies: Dependencies
    private let data: CampaignDetailsData

    init(data: CampaignDetailsData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() async {
        episode?.displayBackAction(data.onBack)

        let infoData = CampaignDetailsEpisode.CampaignInfoData(
            title: data.info.name,
            description: data.info.description,
            image: data.info.image
        )
        episode?.displayCampaignInfo(infoData)
        let campaignResult = await asyncResult {
            try await dependencies.campaignLoader.loadCampaign(id: data.info.id)
        }

        let campaignData = campaignResult.map { campaign in
            CampaignDetailsEpisode.LoadedCampaignData(
                onStart: { [data] in
                    data.onStartCampaign(campaign)
                }
            )
        }
        episode?.displayCampaignData(campaignData)
    }
}
