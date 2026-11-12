//
//  GameEpisode.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2023.
//

import Foundation
import Prelude

class GameEpisode<ViewModel: GameEpisodeViewModel>: BaseGameEpisode {
    private var viewModel: ViewModel
    private let logger = Logger()

    init(episodes: Episodes, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(episodes: episodes)
    }

    override func prepare() {
        viewModel.episode = self as? ViewModel.Episode
        if viewModel.episode == nil {
            logger.assertionError("""
            GameEpisode failed to cast episode \(self) \
            to \(ViewModel.Episode.self)
            """)
        }

        super.prepare()
        Task { await viewModel.didBegin() }
    }

    override func finalize() {
        viewModel.willEnd()
        super.finalize()
    }
}
