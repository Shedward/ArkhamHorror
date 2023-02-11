//
//  MenuScene.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit

final public class MenuScene: SKScene {
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
        anchorPoint = .init(x: 0.5, y: 0.5)

        let itemSize = CGSize(width: 128, height: 256)

        let dataSource = ArrayDataSource(data: ["One", "Two", "Three"])
        let cellProvider = FnCollectionCellProvider { (title: String) -> Button in
            Button(
                texture: .init(imageNamed: title),
                size: itemSize,
                onTap: nil
            )
        }
        let collection = Collection(
            size: size,
            dataSource: dataSource,
            layout: CenteredRowLayout(itemSize: itemSize, spacing: 32),
            cellProvider: cellProvider
        )

        addChild(collection.node)
    }
}
