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

    func didBegin() {
        Task {
            episode?.displayBackAction(output.onBack)

            let infoData = CampaignDetailsEpisode.CampaignInfoData(
                title: info.name,
                description: info.description,
                image: info.image
            )
            episode?.displayCampaignInfo(infoData)
            let loadingCampaign = await Loading.async {
                try await dependencies.campaignLoader.loadCampaign(id: info.id)
            }
            let loadingCharacters = loadingCampaign.map { campaign in
                campaign.availableCharacters.map { character in
                    CampaignDetailsEpisode.CharacterData(
                        name: character.name,
                        portrait: character.portrait
                    )
                }
            }
            episode?.displayCharacters(loadingCharacters)
        }
    }
}
