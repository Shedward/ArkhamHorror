//
//  SelectCampaignModule.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Prelude
import ArkhamHorror
import SpriteKit

protocol SelectCampaignSceneProtocol: AnyObject {
    func displayCampaigns(_ loading: Loading<[CampaignInfo]>)
}

extension Scenes {
    public func selectCampaign(
        campaignLoader: CampaignLoader,
        onCampaignSelected: @escaping (CampaignInfo) -> Void
    ) -> SKScene {
        let viewModel = SelectCampaignViewModel(
            campaignLoader: campaignLoader,
            onCampaignSelected: onCampaignSelected
        )
        let scene = SelectCampaignScene(size: size, viewModel: viewModel)
        return scene
    }
}
