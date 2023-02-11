//
//  MainScene.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

final public  class MainScene: SKScene {
    public override init(size: CGSize) {
        super.init(size: size)
        configureScene()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureScene() {
        scaleMode = .aspectFit
        name = "MainScene"

        let buttonsStack = Stack(axis: .horizontal, spacing: 4) {
            TextureButton(texture: SKTexture(imageNamed: "wrong"), onTap: nil)
            TextureButton(texture: SKTexture(imageNamed: "wrong"), onTap: nil)
            TextureButton(texture: SKTexture(imageNamed: "wrong"), onTap: nil)
            TextureButton(texture: SKTexture(imageNamed: "wrong"), onTap: nil)
        }

        addChild(buttonsStack.node)
    }
}
