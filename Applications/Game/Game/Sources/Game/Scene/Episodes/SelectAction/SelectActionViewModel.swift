//
//  SelectActionViewModel.swift
//  
//
//  Created by Vladislav Maltsev.
//

final class SelectActionViewModel: GameEpisodeViewModel {
    typealias Dependencies = Any

    weak var episode: SelectActionView?
    private let dependencies: Dependencies
    private let data: SelectActionData

    init(data: SelectActionData, dependencies: Dependencies) {
        self.data = data
        self.dependencies = dependencies
    }

    func didBegin() {
        let dismiss: () -> Void = { [weak self] in
            self?.episode?.end()
        }
        let actions: [ActionCell.Data] = [
            ActionCell.Data(title: "Move", onTap: dismiss),
            ActionCell.Data(title: "Research", onTap: dismiss),
            ActionCell.Data(title: "Ward", onTap: dismiss)
        ]
        episode?.displayActions(actions)
    }
}
