//
//  MenuScene.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit

final public  class MenuScene: SKScene {
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
        name = "MenuScene"

        func createButton() -> View {
            Button(
                texture: SKTexture(imageNamed: "wrong"),
                size: .init(width: 128, height: 256),
                onTap: nil
            )
        }

        let buttonsStack = HStack(
            views:
                createButton(),
                createButton(),
                createButton(),
                createButton(),
            spacing: 4
        )

        let centered = Centered(buttonsStack, size: size)

        addChild(centered.node)
    }
}
