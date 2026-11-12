//
//  ActionPhaseEpisodeModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Common
import ArkhamHorror
import simd
import DesignSystem

protocol SelectPathEpisodeView: AnyObject {
    func displayPathHighlight(at points: [vector_float2], color: UColor)
    func hidePathHighlight()
}

struct SelectPathEpisodeData {
    let game: Game
    let fromPlayer: Player
    let onSelected: ([Region.ID]) -> Void
}

extension Episodes {
    @MainActor
    func selectPath(data: SelectPathEpisodeData) -> BaseGameEpisode {
        let viewModel = SelectPathEpisodeViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = SelectPathEpisode(episodes: self, viewModel: viewModel)
        return episode
    }
}
