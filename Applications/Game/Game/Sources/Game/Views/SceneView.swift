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
import Scenes

#if os(macOS)

struct SceneView: NSViewRepresentable {
    var scene: SCNScene?
    var overlay: SKScene?
    private let logger = Logger()

    init(scene: SCNScene?, overlay: SKScene?) {
        self.scene = scene
        self.overlay = overlay
    }

    func makeNSView(context: Context) -> SCNGameView {
        return SCNGameView(frame: .zero)
    }

    func updateNSView(_ nsView: SCNGameView, context: Context) {
        nsView.scene = scene ?? SCNScene()
        nsView.overlaySKScene = overlay ?? SKScene()
        nsView.backgroundColor = .black
    }
}

#else

struct SceneView: UIViewRepresentable {
    var scene: SCNScene?
    var overlay: SKScene?
    private let logger = Logger()

    init(scene: SCNScene?, overlay: SKScene?) {
        self.scene = scene
        self.overlay = overlay
        self.sceneSelectionBehaviour = sceneSelectionBehaviour
    }

    func makeUIView(context: Context) -> SCNGameView {
        return SCNView()
    }

    func updateUIView(_ uiView: SCNGameView, context: Context) {
        uiView.scene = scene ?? SCNScene()
        uiView.backgroundColor = .black
        uiView.overlaySKScene = overlay
        sceneSelectionBehaviour = SCNSelectableBehaviour(sceneView: uiView)
    }
}

#endif
