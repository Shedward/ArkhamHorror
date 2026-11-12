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

    var onTap: (() -> Void)?
    var onAppearanceChange: ((TappableShapeNode) -> Void)?

#if os(macOS)
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        isSelected = true
    }

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        isSelected = false

        if let scene, containsHit(at: event.location(in: scene), in: scene) {
            onTap?()
        }
    }

#elseif os(iOS)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = false
        if let touch = touches.first, let scene, containsHit(at: touch.location(in: scene), in: scene) {
            onTap?()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = false
    }
#endif
}
