//
//  SceneView.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import Prelude
import SwiftUI
import SpriteKit
import SceneKit

#if os(macOS)

struct SceneView: NSViewRepresentable {
    var scene: SCNScene?
    var overlay: SKScene?
    var onTilt: ((Tilt) -> Void)?

    private let logger = Logger()

    func makeNSView(context: Context) -> GameSceneView {
        return GameSceneView(frame: .zero)
    }

    func updateNSView(_ nsView: GameSceneView, context: Context) {
        nsView.scene = scene ?? SCNScene()
        nsView.overlaySKScene = overlay ?? SKScene()
        nsView.backgroundColor = .black
        nsView.onTilt = onTilt
    }
}

#else

struct SceneView: UIViewRepresentable {
    var scene: SCNScene?
    var overlay: SKScene?
    var onTilt: ((Tilt) -> Void)?

    private let logger = Logger()

    func makeUIView(context: Context) -> GameSceneView {
        return GameSceneView(frame: .zero)
    }

    func updateUIView(_ uiView: GameSceneView, context: Context) {
        uiView.scene = scene ?? SCNScene()
        uiView.backgroundColor = .black
        uiView.overlaySKScene = overlay
        uiView.onTilt = onTilt
    }
}

#endif

extension SceneView {
    func onTilt(_ onTiltAction: @escaping (Tilt) -> Void) -> Self {
        var result = self
        result.onTilt = onTiltAction
        return result
    }
}
