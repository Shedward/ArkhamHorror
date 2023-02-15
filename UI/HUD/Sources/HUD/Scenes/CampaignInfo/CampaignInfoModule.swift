//
//  CampaignInfoModule.swift
//  
//
//  Created by Vladislav Maltsev on 13.02.2023.
//

import Prelude
import ArkhamHorror
import SpriteKit

protocol CampaignInfoSceneProtocol: AnyObject {
    func displayInitialInfo(_ campaignInfo: CampaignInfoScene.CampaignInfoData)
    func displayCampaign(_ loading: Loading<CampaignInfoScene.CampaignLoadedData>)
}

public struct CampaignInfoOutput {
    public let onStartCampaign: (Campaign) -> Void
    public let onBack: () -> Void

    public init(
        onStartCampaign: @escaping (Campaign) -> Void,
        onBack: @escaping () -> Void
    ) {
        self.onStartCampaign = onStartCampaign
        self.onBack = onBack
    }
}

extension HUDScenes {
    @MainActor
    public func campaignInfo(_ campaignInfo: CampaignInfo, output: CampaignInfoOutput) -> SKScene {
        let viewModel = CampaignInfoViewModel(
            campaignInfo: campaignInfo,
            dependencies: dependencies,
            output: output
        )
        let scene = CampaignInfoScene(size: size, viewModel: viewModel)
        return scene
    }
}
