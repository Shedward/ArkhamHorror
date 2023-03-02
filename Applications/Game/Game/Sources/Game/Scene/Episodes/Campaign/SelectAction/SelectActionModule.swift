//
//  SelectActionModule.swift
//  
//
//  Created by Vladislav Maltsev.
//

import ArkhamHorror
import HUD

protocol SelectActionView: AnyObject {
    func displayActions(_ actions: [ActionCell.Data])
    func end()
}

struct SelectActionData {
    let player: Player
}

extension Episodes {
    @MainActor
    func selectAction(data: SelectActionData, from anchor: View) -> BaseGameEpisode {
        let viewModel = SelectActionViewModel(
            data: data,
            dependencies: dependencies
        )
        let episode = SelectActionEpisode(episodes: self, viewModel: viewModel, from: anchor)
        return episode
    }
}
