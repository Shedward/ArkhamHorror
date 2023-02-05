//
//  MainScene.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

extension Scenes {
    public static func main() -> SKScene {
        let scene = SKScene(size: .init(width: 512, height: 512))
        scene.scaleMode = .aspectFit
        scene.name = "MainScene"
        configureContent(in: scene)
        return scene
    }

    private static func configureContent(in root: SKNode) {
        let buttonsStack = HStack(
            views:
                Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
                Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
                Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
                Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
            spacing: 4
        )
        root.addChild(buttonsStack.node)
    }
}
