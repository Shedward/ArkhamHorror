//
//  SelectPathEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import Scenes
import simd
import DesignSystem

final class SelectPathEpisode: GameEpisode<SelectPathEpisodeViewModel> {
    private var pathHighlight: PathHightlight?
}

extension SelectPathEpisode: SelectPathEpisodeView {
    func displayPathHighlight(at points: [vector_float2]) {
        hidePathHighlight()
        let pathHighlight = PathHightlight(points: points, elevation: Scenes.Player.elevation)
        addObject(pathHighlight, transition: FadeObjectTransition())
        self.pathHighlight = pathHighlight
    }

    func hidePathHighlight() {
        guard let pathHighlight else { return }
        removeObject(pathHighlight)
    }
}
