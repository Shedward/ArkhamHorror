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
import DesignSystem
import HUD
import Scenes


@MainActor
public struct MainView: SwiftUI.View {
    let dependencies: Dependencies
    let episodes: Episodes
    let logger = Logger()

    private let gameScene: GameScene
    private let mainEpisode: BaseGameEpisode

    @Environment(\.design)
    var design: DesignSystem

    public init() throws {
        let size = Self.screenSize
        gameScene = GameScene(size: size)
        dependencies = try Dependencies()
        episodes = Episodes(size: size, dependencies: dependencies)
        mainEpisode = episodes.main()
    }

    public var body: some SwiftUI.View {
        SceneView(scene: gameScene.scene3d, overlay: gameScene.overlay)
            .onTilt { tilt in gameScene.tilt.send(tilt) }
            .aspectRatio(gameScene.size.width / gameScene.size.height, contentMode: .fit)
            .background(Color(design.color.background.main))
            .onAppear {
                startMainEpisode()
            }
    }

    func startMainEpisode() {
        mainEpisode.start(in: gameScene)
    }

    static var screenSize: CGSize {
        let defaultSize = CGSize(width: 1280, height: 720)
        #if os(macOS)
        return NSScreen.main?.frame.size ?? defaultSize
        #elseif os(iOS)
        return UIScreen.main?.frame.size ?? defaultSize
        #else
        return defaultSize
        #endif
    }
}
