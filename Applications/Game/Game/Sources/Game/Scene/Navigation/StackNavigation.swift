//
//  EpisodeStackNavigation.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

import Prelude

@MainActor
final class StackNavigation {
    private var episodes: [BaseGameEpisode] = []
    private weak var rootEpisode: BaseGameEpisode?
    private let logger = Logger()

    var currentEpisode: BaseGameEpisode? {
        episodes.last
    }

    init(rootEpisode: BaseGameEpisode) {
        self.rootEpisode = rootEpisode
    }

    func push(_ episode: BaseGameEpisode) {
        guard let rootEpisode else {
            logger.assertionError("""
            Tried to push episode \(episode) to navigation \
            which does not have root episode.
            """)
            return
        }

        if let currentEpisode {
            currentEpisode.end()
        }
        rootEpisode.startChildEpisode(episode)
        episodes.append(episode)
    }

    func pop() {
        guard let rootEpisode else {
            logger.assertionError("""
            Tried to pop episode from navigation \
            which does not have root episode.
            """)
            return
        }

        guard
            let previousEpisode = episodes.suffix(2).first,
            let currentEpisode
        else {
            logger.assertionError("""
            Tried to pop episode from navigation \
            which have only \(episodes.count) episodes: \
            \(episodes)
            """)
            return
        }

        currentEpisode.end()
        rootEpisode.startChildEpisode(previousEpisode)
        episodes = episodes.dropLast()
    }
}
