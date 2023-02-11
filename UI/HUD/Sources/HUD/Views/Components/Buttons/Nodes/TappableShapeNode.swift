//
//  TappableShapeNode.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit

final class TappableShapeNode: SKShapeNode {
    var isSelected: Bool = false {
        didSet {
            onAppearanceChange?(self)
        }
    }

    var onTap: (() -> Void)?;
    var onAppearanceChange: ((TappableShapeNode) -> Void)?

#if os(macOS)
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        isSelected = true
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        isSelected = false

        if containsTouches(event) {
            onTap?()
        }
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
