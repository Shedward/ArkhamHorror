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
    private var charactersCollection: Collection<CharacterCell.Data, CharacterCell>?

    override func willBegin() {
        let backButton = TextButton(text: Localized.string("Back"))
        self.backButton = backButton
        let backContainer = AlignedToTopLeft(backButton, size: overlaySize)
        addView(backContainer)

        let charactersCollection = Collection(
            size: CGSize(width: overlaySize.width, height: CharacterCell.size.height),
            of: CharacterCell.self,
            layout: CenteredRowLayout(itemSize: CharacterCell.size, spacing: 16)
        )
        self.charactersCollection = charactersCollection
        let charactersContainer = AlignedToBottom(charactersCollection, size: overlaySize)
        addView(charactersContainer)
    }
}

extension CampaignEpisode: CampaignEpisodeProtocol {
    func displayBackAction(_ back: Action) {
        backButton?.onTap = back
    }

    func displayCharacters(_ characters: [CharacterCell.Data]) {
        charactersCollection?.dataSource = ArrayCollectionDataSource(data: characters).asAny()
        layout()
    }
}


