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

    override func willBegin() {
        let campaignCollection = Collection(
            size: overlaySize,
            of: CampaignCell.self,
            layout: CenteredRowLayout(itemSize: CampaignCell.size, spacing: 64)
        )
        addView(campaignCollection)
        self.campaignCollection = campaignCollection

        let errorAlert = ErrorAlert()
        addView(errorAlert)
        self.errorAlert = errorAlert
    }

    func displayCampaigns(_ loadingCampaigns: Loading<[CampaignCell.Data]>) {
        let models = loadingCampaigns.value ?? []
        campaignCollection?.dataSource = ArrayCollectionDataSource(data: models).asAny()
        errorAlert?.display(loadingCampaigns.error)
        layout()
    }
}
