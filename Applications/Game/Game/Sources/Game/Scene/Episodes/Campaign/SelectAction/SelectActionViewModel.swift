//
//  SelectActionViewModel.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Prelude
import DesignSystem

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
                    self?.dependencies.animationQueue.enqueue {
                        self?.movePlayerToRandomNeighbourRegion()
                        self?.movePlayerToRandomNeighbourRegion()
                    }
                }
            )
        ]
        episode?.displayActions(actions)
    }

    private func movePlayerToRandomNeighbourRegion() {
        do {
            try data.player.moveToRandomNeighbourRegion()
            episode?.end()
        } catch {
            episode?.displayError(error) { [weak self] in
                self?.episode?.end()
            }
        }
    }
}
