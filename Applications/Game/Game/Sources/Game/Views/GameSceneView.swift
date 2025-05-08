//
//  GameSceneView.swift
//  Game
//
//  Created by Vlad Maltsev on 07.05.2025.
//

import Prelude
import SceneKit

public class GameSceneView: SCNView {
    var onTilt: ((CGVector) -> Void)?

    private var collectedTilt: CGVector = .zero {
        didSet {
            onTilt?(collectedTilt)
        }
    }

    override public init(frame: NSRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)

        #if os(iOS)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 2
        addGestureRecognizer(panGestureRecognizer)
        #endif
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    #if os(macOS)
    override public func scrollWheel(with event: NSEvent) {
        let maxTilt = 100.0
        collectedTilt = CGVector(
            dx: clamp(collectedTilt.dx + event.scrollingDeltaX, min: 0, max: maxTilt),
            dy: clamp(collectedTilt.dy + event.scrollingDeltaY, min: 0, max: maxTilt)
        )
    }
    #elseif os(iOS)
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)
        let tilt = Tilt(dx: translation.x, dy: translation.y)
        onTilt?(tilt)
    }
    #endif
}
