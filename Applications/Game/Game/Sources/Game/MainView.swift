//
//  MainView.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SwiftUI
import SceneKit
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
    private var scene: SCNScene?
    @State
    private var overlay: SKScene?

    public init() throws {
        dependencies = try Dependencies()
        hudScenes = HUDScenes(size: size, dependencies: dependencies)
    }

    public var body: some SwiftUI.View {
        SceneView(scene: scene, overlay: overlay)
            .frame(width: size.width, height: size.height)
            .onAppear {
                displayCampaigns()
            }
    }

    private func displayCampaigns() {
        let output = SelectCampaignOutput(
            onCampaignSelected: { campaignInfo in
                displayCampaignInfo(campaignInfo)
            }
        )

        overlay = hudScenes.selectCampaign(output: output)
        scene = nil
    }

    private func displayCampaignInfo(_ campaignInfo: CampaignInfo) {
        let output = CampaignInfoOutput(
            onStartCampaign: { campaign in
                displayCampaignGameboard(campaign)
            },
            onBack: {
                displayCampaigns()
            }
        )

        overlay = hudScenes.campaignInfo(campaignInfo, output: output)
        scene = nil
    }

    private func displayCampaignGameboard(_ campaign: Campaign) {
        let output = CampaignGameboardOutput(
            onBack: {
                displayCampaigns()
            }
        )
        overlay = hudScenes.campaignGameboard(campaign, output: output)
        scene = Scenes.mapScene(campaign.map)
    }
}
