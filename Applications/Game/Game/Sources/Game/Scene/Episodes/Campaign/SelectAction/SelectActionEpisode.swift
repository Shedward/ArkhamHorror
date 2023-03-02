//
//  SelectActionEpisode.swift
//  
//
//  Created by Vladislav Maltsev.
//

import HUD

final class SelectActionEpisode: GameEpisode<SelectActionViewModel> {
    private let anchor: View
    private var actionsCollection: Collection<ActionCell.Data, ActionCell>?

    init(episodes: Episodes, viewModel: SelectActionViewModel, from anchor: View) {
        self.anchor = anchor
        super.init(episodes: episodes, viewModel: viewModel)
    }

    override func willBegin() {
        let actionsCollection = Collection(
            size: overlaySize,
            of: ActionCell.self,
            layout: CenteredRowLayout(itemSize: ActionCell.size, spacing: 16)
        )
        self.actionsCollection = actionsCollection

        let anchoredActions = AnchoredOver(actionsCollection, over: anchor, containerSize: overlaySize)
        addView(anchoredActions)
    }
}

extension SelectActionEpisode: SelectActionView {
    func displayActions(_ actions: [ActionCell.Data]) {
        actionsCollection?.dataSource = ArrayCollectionDataSource(data: actions).asAny()
        layout()
    }
}


