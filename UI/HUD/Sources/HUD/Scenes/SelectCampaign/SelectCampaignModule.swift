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
    func displayCampaigns(_ loading: Loading<[CampaignCell.Data]>)
}

public struct SelectCampaignOutput {
    public let onCampaignSelected: (CampaignInfo) -> Void

    public init(onCampaignSelected: @escaping (CampaignInfo) -> Void) {
        self.onCampaignSelected = onCampaignSelected
    }
}

extension HUDScenes {
    @MainActor
    public func selectCampaign(output: SelectCampaignOutput) -> SKScene {
        let viewModel = SelectCampaignViewModel(dependencies: dependencies, output: output)
        let scene = SelectCampaignScene(size: size, viewModel: viewModel)
        return scene
    }
}
