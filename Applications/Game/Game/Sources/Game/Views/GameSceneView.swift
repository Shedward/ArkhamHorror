//
//  GameSceneView.swift
//  Game
//
//  Created by Vlad Maltsev on 07.05.2025.
//

import SceneKit

public struct Tilt {
    static let zero: Tilt = .init(dx: 0, dy: 0)

    public let dx: CGFloat
    public let dy: CGFloat
}

public class GameSceneView: SCNView {
    var onTilt: ((Tilt) -> Void)?

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
        let tilt = Tilt(dx: event.scrollingDeltaX, dy: event.scrollingDeltaY)
        onTilt?(tilt)
    }
    #elseif os(iOS)
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)
        let tilt = Tilt(dx: translation.x, dy: translation.y)
        onTilt?(tilt)
    }
    #endif
}
