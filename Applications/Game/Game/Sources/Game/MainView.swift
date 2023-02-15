//
//  MainView.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SwiftUI
import SpriteKit

import Prelude
import ArkhamHorror
import HUD
import Scenes


@MainActor
public struct MainView: SwiftUI.View {
    let size: CGSize = .init(width: 1280, height: 720)
    let dependencies: Dependencies
    let hudScenes: HUDScenes
    let logger = Logger()

    @State
    private var overlay: SKScene?

    public init() throws {
        dependencies = try Dependencies()
        hudScenes = HUDScenes(size: size, dependencies: dependencies)
    }

    public var body: some SwiftUI.View {
        SceneView(overlay: overlay ?? displayCampaignsOverlay())
            .frame(width: size.width, height: size.height)
    }

    private func displayCampaignsOverlay() -> SKScene {
        let output = SelectCampaignOutput(
            onCampaignSelected: { campaignInfo in
                displayCampaignInfo(campaignInfo)
            }
        )

        return hudScenes.selectCampaign(output: output)
    }

    private func displayCampaigns() {
        let output = SelectCampaignOutput(
            onCampaignSelected: { campaignInfo in
                displayCampaignInfo(campaignInfo)
            }
        )

        overlay = hudScenes.selectCampaign(output: output)
    }

    private func displayCampaignInfo(_ campaignInfo: CampaignInfo) {
        let output = CampaignInfoOutput(
            onStartCampaign: { campaign in
                logger.info("Open campaign \(campaign)")
            },
            onBack: {
                displayCampaigns()
            }
        )

        overlay = hudScenes.campaignInfo(campaignInfo, output: output)
    }
}
