//
//  Centered.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit
import Prelude

public final class Centered: View {
    init(_ view: View, size: CGSize) {
        let node = view.node
        let childFrame = node.calculateAccumulatedFrame()
        let position = 0.5 * size.point() - 0.5 * childFrame.size.point()
        node.position = position
        super.init(node: node)
    }
}
