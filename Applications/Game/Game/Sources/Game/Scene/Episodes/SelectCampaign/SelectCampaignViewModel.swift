//
//  SelectCampaignViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 21.02.2023.
//

import ArkhamHorror
import HUD
import Prelude

final class SelectCampaignViewModel: GameEpisodeViewModel {
    typealias Dependencies = CampaignLoaderDependency

    weak var episode: SelectCampaignEpisodeProtocol?
    private let dependencies: Dependencies
    private let output: SelectCampaignOutput

    init(dependencies: Dependencies, output: SelectCampaignOutput) {
        self.dependencies = dependencies
        self.output = output
    }

    func didBegin() {
        Task {
            episode?.displayCampaigns(.loading)
            let loadingCampaignInfo = await Loading.async { try await dependencies.campaignLoader.campaignsInfo() }
            let loadingCampaignData = loadingCampaignInfo.map { infos in
                infos.map { info in
                    CampaignCell.Data(
                        name: info.name,
                        image: info.image,
                        onTap: { [output] in output.didSelectCampaign(info) }
                    )
                }
            }
            episode?.displayCampaigns(loadingCampaignData)
        }
    }
}
