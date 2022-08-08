//
//  PlayerPresentation.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

protocol PlayerPresentation: AnyObject {
    func updateAvailableActions(_ availableActionsCount: Int)
}

public final class AnyPlayerPresentation: PlayerPresentation {
    private let wrapped: PlayerPresentation

    init(wrapped: PlayerPresentation) {
        self.wrapped = wrapped
    }

    func updateAvailableActions(_ availableActionsCount: Int) {
        wrapped.updateAvailableActions(availableActionsCount)
    }
}
