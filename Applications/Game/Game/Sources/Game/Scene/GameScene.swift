//
//  GameScreen.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit
import ArkhamHorror

@MainActor
final class GameScene {


    let overlay: SKScene
    let scene3d: SCNScene

    private var episodes: [GameEpisodeProtocol] = []

    init(size: CGSize) {
        overlay = SKScene(size: size)
        overlay.backgroundColor = .black
        overlay.anchorPoint = .init(x: 0.5, y: 0.5)

        scene3d = SCNScene()
    }

    func startEpisode(_ episode: GameEpisodeProtocol) async {
        episode.scene = self
        await episode.begin()
        episodes.append(episode)
    }

    func endEpisode(_ episode: GameEpisodeProtocol) async {
        await episode.end()
        episodes.removeAll { $0 === episode }
    }
}
