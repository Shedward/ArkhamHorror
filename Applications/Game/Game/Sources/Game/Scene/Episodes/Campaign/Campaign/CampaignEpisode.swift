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
    private var playersCollection: Collection<PlayerCell.Data, PlayerCell>?

    override func willBegin() {
        let backButton = TextButton(text: Localized.string("Back"))
        self.backButton = backButton
        let backContainer = AlignedToTopLeft(backButton, size: overlaySize)
        addView(backContainer)

        let charactersCollection = Collection(
            size: CGSize(width: overlaySize.width, height: PlayerCell.size.height),
            of: PlayerCell.self,
            layout: CenteredRowLayout(itemSize: PlayerCell.size, spacing: 16)
        )
        self.playersCollection = charactersCollection
        let charactersContainer = AlignedToBottom(charactersCollection, size: overlaySize)
        addView(charactersContainer)
    }
}

extension CampaignEpisode: CampaignView {
    func displayBackAction(_ back: Action) {
        backButton?.onTap = back
    }

    func displayCharacters(_ characters: [PlayerCell.Data]) {
        playersCollection?.dataSource = ArrayCollectionDataSource(data: characters).asAny()
        layout()
    }

    func presentActions(_ data: SelectActionData) {
        let cell = playersCollection?.cells.first { $0.id == data.player.id }
        guard let anchor = cell ?? playersCollection else { return }
        let episode = episodes.selectAction(data: data, from: anchor)
        startChildEpisode(episode)
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


