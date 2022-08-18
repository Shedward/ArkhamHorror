//
//  Presentation.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Foundation
import Prelude

class Presentation {
    weak var game: GamePresentation?
    weak var map: MapPresentation?
    var players: [Player.ID: WeakBox<AnyPlayerPresentation>] = [:]
}
