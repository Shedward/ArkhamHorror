//
//  CampaignEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD
import CoreGraphics
import Prelude

final class CampaignEpisode: GameEpisode<CampaignViewModel> {

    private var backButton: TextButton?

    override func willBegin() {
        let backButton = TextButton(text: Localized.string("Back"))
        self.backButton = backButton
        let backContainer = AlignedToTopLeft(backButton, size: overlaySize)
        addView(backContainer)
    }
}

extension CampaignEpisode: CampaignView {
    func displayBackAction(_ back: Action) {
        backButton?.onTap = back
    }

    func presentGameboard(_ data: GameboardData) {
        let episode = episodes.map(data: data)
        startChildEpisode(episode)
    }

    func presentPlayers(_ data: PlayersData) {
        let episode = episodes.players(data: data)
        startChildEpisode(episode)
    }
}


