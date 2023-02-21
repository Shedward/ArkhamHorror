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

    private let gameScene: GameScene

    public init() throws {
        gameScene = GameScene(size: size)
        dependencies = try Dependencies()
        episodes = Episodes(size: size, dependencies: dependencies)
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
        let selectCampaignEpisode = episodes.selectCampaign(output: output)
        Task { await gameScene.startEpisode(selectCampaignEpisode) }
    }

    private func displaySelectedCampaign(info: CampaignInfo) {

    }
}
