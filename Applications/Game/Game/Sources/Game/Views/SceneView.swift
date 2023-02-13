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
    private let logger = Logger()

    func makeNSView(context: Context) -> SCNView {
        return SCNView()
    }

    func updateNSView(_ nsView: SCNView, context: Context) {
        nsView.scene = scene ?? SCNScene()
        nsView.backgroundColor = .black
        nsView.overlaySKScene = overlay
    }
}

#else

struct SceneView: UIViewRepresentable {
    var scene: SCNScene?
    var overlay: SKScene?
    private let logger = Logger()

    func makeUIView(context: Context) -> SCNView {
        return SCNView()
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = scene ?? SCNScene()
        uiView.backgroundColor = .black
        uiView.overlaySKScene = overlay
    }
}

#endif
