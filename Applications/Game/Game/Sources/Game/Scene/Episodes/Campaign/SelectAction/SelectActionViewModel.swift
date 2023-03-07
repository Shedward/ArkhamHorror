//
//  SelectActionViewModel.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Prelude
import DesignSystem
import Common

final class SelectActionViewModel: GameEpisodeViewModel {
    typealias Dependencies = AnimationQueueDependency

    weak var episode: SelectActionView?
    private let dependencies: Dependencies
    private let data: SelectActionData

    init(data: SelectActionData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
        let actions: [ActionCell.Data] = [
            ActionCell.Data(
                id: "move",
                title: Localized.string("Move"),
                onTap: { [weak self] in
                    self?.presentSelectPath()
                }
            )
        ]
        episode?.displayActions(actions)
    }

    private func presentSelectPath() {
        let data = SelectPathEpisodeData(
            game: data.game,
            fromPlayer: data.player,
            onSelected: { [weak self] path in
                self?.movePlayer(path: path)
                self?.episode?.end()
            }
        )
        episode?.presentSelectPath(data)
    }

    private func movePlayer(path: [Region.ID]) {
        dependencies.animationQueue.enqueue {
            try! data.player.move(path: path)
        }
    }
}
