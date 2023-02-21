//
//  SelectCampaignEpisode.swift
//  
//
//  Created by Vladislav Maltsev on 21.02.2023.
//

import DesignSystem
import HUD
import CoreGraphics
import Prelude

final class SelectCampaignEpisode: GameEpisode<SelectCampaignViewModel>, SelectCampaignEpisodeProtocol {

    private var campaignCollection: Collection<CampaignCell.Data, CampaignCell>?
    private var errorAlert: ErrorAlert?

    override func begin() async {
        await super.begin()

        let campaignCollection = Collection(
            size: overlaySize,
            of: CampaignCell.self,
            layout: CenteredRowLayout(itemSize: CampaignCell.size, spacing: 64)
        )
        await addView(campaignCollection)
        self.campaignCollection = campaignCollection

        let errorAlert = ErrorAlert()
        await addView(errorAlert)
        self.errorAlert = errorAlert
    }

    func displayCampaigns(_ loadingCampaigns: Loading<[CampaignCell.Data]>) {
        let models = loadingCampaigns.value ?? []
        campaignCollection?.dataSource = ArrayCollectionDataSource(data: models).asAny()
        errorAlert?.display(loadingCampaigns.error)
        layout()
    }
}
