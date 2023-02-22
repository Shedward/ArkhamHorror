//
//  GameScreen.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit
import ArkhamHorror
import Prelude

@MainActor
final class GameScene {
    let overlay: SKScene
    let scene3d: SCNScene

    private var episodes: [GameEpisodeProtocol] = []
    private let logger = Logger()

    init(size: CGSize) {
        overlay = SKScene(size: size)
        overlay.backgroundColor = .black
        overlay.anchorPoint = .init(x: 0.5, y: 0.5)

        scene3d = SCNScene()
    }

    func startEpisode(_ episode: GameEpisodeProtocol) async {
        episode.scene = self
        await episode.begin()
        logger.info("Started episode \(episode)")
        episodes.append(episode)
    }

    func endEpisode(_ episode: GameEpisodeProtocol) async {
        await episode.end()
        logger.info("Ended episode \(episode)")
        episodes.removeAll { $0 === episode }
    }

    func endEpisode<Episode: GameEpisodeProtocol>(
        _ type: Episode.Type,
        where test: (Episode) -> Bool = { _ in true }
    ) async {
        guard let episode = episodes.first(
            where: { $0 is Episode && test($0 as! Episode) }
        ) else { return }
        await endEpisode(episode)
    }
}
