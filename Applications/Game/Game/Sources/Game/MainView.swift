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
    let episodes: Episodes
    let logger = Logger()
    let navigation: EpisodeStackNavigation

    private let gameScene: GameScene

    public init() throws {
        gameScene = GameScene(size: size)
        dependencies = try Dependencies()
        episodes = Episodes(size: size, dependencies: dependencies)
        navigation = EpisodeStackNavigation(scene: gameScene)
    }

    public var body: some SwiftUI.View {
        SceneView(scene: gameScene.scene3d, overlay: gameScene.overlay)
            .frame(width: size.width, height: size.height)
            .onAppear {
                displayCampaigns()
            }
    }

    private func displayCampaigns() {
        let output = SelectCampaignOutput(
            didSelectCampaign: { info in
                displaySelectedCampaign(info: info)
            }
        )
        let episode = episodes.selectCampaign(output: output)
        navigation.push(episode)
    }

    private func displaySelectedCampaign(info: CampaignInfo) {
        let output = CampaignDetailsOutput(
            onBack: {
                navigation.pop()
            },
            onStartCampaign: { campaign in
                displayCampaign(campaign)
            }
        )
        let episode = episodes.campaignDetails(info: info, output: output)
        navigation.push(episode)
    }

    private func displayCampaign(_ campaign: Campaign) {
        let output = CampaignOutput(
            onBack: {
                navigation.pop()
            }
        )
        let episode = episodes.campaign(campaign: campaign, output: output)
        navigation.push(episode)
    }
}
