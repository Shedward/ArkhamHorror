//
//  Scroll.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit

public final class Scroll: View {
    public let node: SKNode

    public init(
        texture: SKTexture,
        size: CGSize,
        content: View
    ) {
        let node = ScrollNode(size: size)
        self.node = node
    }
}

final class ScrollNode: SKNode {
    private let size: CGSize
    private var contentOffset: CGPoint = .zero

    init(size: CGSize) {
        self.size = size
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

#if os(macOS)
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
    }

    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
    }

    private func containsTouches(_ event: NSEvent) -> Bool {
        guard let scene else {
            return false
        }

        let touchPoint = event.location(in: scene)
        let touchedNode = scene.atPoint(touchPoint)
        return touchedNode === self
    }
#endif
}
