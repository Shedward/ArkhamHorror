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
    func displayCampaign(_ loading: Loading<Campaign>)
}

public struct CampaignInfoOutput {
    public let onStartCampaign: (Campaign) -> Void

    public init(onStartCampaign: @escaping (Campaign) -> Void) {
        self.onStartCampaign = onStartCampaign
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
