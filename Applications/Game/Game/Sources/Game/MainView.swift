//
//  MainView.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SwiftUI
import HUD
import Scenes
import Prelude

public struct MainView: SwiftUI.View {
    let size: CGSize = .init(width: 1280, height: 720)
    let dependencies = try! Dependencies()
    let logger = Logger()

    public init() {
    }

    public var body: some SwiftUI.View {
        SceneView(overlay: HUD.Scenes(size: size).selectCampaign(
            campaignLoader: dependencies.campaignLoader,
            onCampaignSelected: { campaignInfo in
                logger.debug("Selected campaignInfo \(campaignInfo)")
            }
        )
        ).frame(width: size.width, height: size.height)
    }
}
