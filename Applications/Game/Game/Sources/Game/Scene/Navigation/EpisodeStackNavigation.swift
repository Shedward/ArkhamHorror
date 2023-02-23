//
//  EpisodeStackNavigation.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

@MainActor
final class EpisodeStackNavigation {
    private var episodes: [GameEpisodeProtocol] = []
    private weak var scene: GameScene?

    var currentEpisode: GameEpisodeProtocol? {
        episodes.last
    }

    init(scene: GameScene) {
        self.scene = scene
    }

    func push(_ episode: GameEpisodeProtocol) {
        if let currentEpisode {
            scene?.endEpisode(currentEpisode)
        }
        scene?.startEpisode(episode)
        episodes.append(episode)
    }

    func pop() {
        guard
            let previousEpisode = episodes.suffix(2).first,
            let currentEpisode,
            let scene
        else { return }

        scene.endEpisode(currentEpisode)
        scene.startEpisode(previousEpisode)
        episodes = episodes.dropLast()
    }
}
