//
//  Centered.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit
import Prelude

public final class Centered: View {
    private let size: CGSize

    public init(_ view: View, size: CGSize) {
        self.size = size
        super.init()
        addChild(view)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let childFrame = node.calculateAccumulatedFrame()
        let position = 0.5 * size.point() - 0.5 * childFrame.size.point()
        node.position = position
    }
}
