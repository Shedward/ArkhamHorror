//
//  CampaignGameboardModule.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import ArkhamHorror
import SpriteKit

protocol CampaignGameboardSceneProtocol: AnyObject {
    func display(_ data: CampaignGameboardScene.Data)
}

public struct CampaignGameboardOutput {
    public let onBack: () -> Void

    public init(onBack: @escaping () -> Void) {
        self.onBack = onBack
    }
}

extension HUDScenes {
    @MainActor
    public func campaignGameboard(_ campaign: Campaign, output: CampaignGameboardOutput) -> SKScene {
        let viewModel = CampaignGameboardViewModel(campaign: campaign, output: output)
        let scene = CampaignGameboardScene(size: size, viewModel: viewModel)
        return scene
    }
}
