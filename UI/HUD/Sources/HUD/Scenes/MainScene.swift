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
        super.init(coder: aDecoder)
        configureScene()
    }

    private func configureScene() {
        scaleMode = .aspectFit
        name = "MainScene"

        let buttonsStack = HStack(
            views:
                Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
            Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
            Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
            Button(texture: SKTexture(imageNamed: "wrong"), onTap: nil),
            spacing: 4
        )

        addChild(buttonsStack.node)
    }
}
