//
//  GameScreen.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

import SpriteKit
import SceneKit
import ArkhamHorror
import Prelude

@MainActor
final class GameScene {
    let overlay: SKScene
    let scene3d: SCNScene

    init(size: CGSize) {
        overlay = SKScene(size: size)
        overlay.backgroundColor = .black
        overlay.anchorPoint = .init(x: 0.5, y: 0.5)

        scene3d = SCNScene()
    }
}
