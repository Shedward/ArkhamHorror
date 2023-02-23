//
//  MainEpisode.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2023.
//

import ArkhamHorror

final class MainEpisode: BaseGameEpisode {
    private var navigation: StackNavigation?

    override func willBegin() {
        super.willBegin()

        let navigation = StackNavigation(rootEpisode: self)
        self.navigation = navigation

        displayCampaigns()
    }

    private func displayCampaigns() {
        let output = SelectCampaignOutput(
            didSelectCampaign: { [weak self] info in
                self?.displaySelectedCampaign(info: info)
            }
        )
        let episode = episodes.selectCampaign(output: output)
        navigation?.push(episode)
    }

    private func displaySelectedCampaign(info: CampaignInfo) {
        let output = CampaignDetailsOutput(
            onBack: { [weak self] in
                self?.navigation?.pop()
            },
            onStartCampaign: { [weak self] campaign in
                self?.displayCampaign(campaign)
            }
        )
        let episode = episodes.campaignDetails(info: info, output: output)
        navigation?.push(episode)
    }

    private func displayCampaign(_ campaign: Campaign) {
        let output = CampaignOutput(
            onBack: { [weak self] in
                self?.navigation?.pop()
            }
        )
        let episode = episodes.campaign(campaign: campaign, output: output)
        navigation?.push(episode)
    }
}
