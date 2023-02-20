//
//  GameScreen.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit
import ArkhamHorror

final class GameScene {
    let overlay: SKScene = .init()
    let scene3d: SCNScene = .init()

    private var episodes: [GameEpisodeProtocol] = []

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
