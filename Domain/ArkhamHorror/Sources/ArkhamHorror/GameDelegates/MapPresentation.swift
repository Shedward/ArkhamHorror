//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Common

protocol MapPresentation: AnyObject {
    func move(player: Player.ID, through path: [Region.ID])
}


public final class AnyMapPresentation: MapPresentation {
    private let wrapped: MapPresentation

    init(wrapped: MapPresentation) {
        self.wrapped = wrapped
    }

    func move(player: Player.ID, through path: [Region.ID]) {
        wrapped.move(player: player, through: path)
    }
}
