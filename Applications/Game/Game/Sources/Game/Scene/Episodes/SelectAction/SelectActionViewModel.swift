//
//  SelectActionViewModel.swift
//  
//
//  Created by Vladislav Maltsev.
//

import Prelude

final class SelectActionViewModel: GameEpisodeViewModel {
    typealias Dependencies = NoDependencies

    weak var episode: SelectActionView?
    private let dependencies: Dependencies
    private let data: SelectActionData

    init(data: SelectActionData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
        func openSubactions(_ id: String) -> () -> Void {
            { [weak self] in
                self?.episode?.end()
            }
        }

        let actions: [ActionCell.Data] = [
            ActionCell.Data(
                id: "move",
                title: Localized.string("Move"),
                onTap: openSubactions("move")
            ),
            ActionCell.Data(
                id: "research",
                title: Localized.string("Research"),
                onTap: openSubactions("research")
            ),
        ]
        episode?.displayActions(actions)
    }
}
