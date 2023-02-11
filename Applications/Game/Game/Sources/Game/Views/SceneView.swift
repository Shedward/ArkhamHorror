//
//  SceneView.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SwiftUI
import SpriteKit
import SceneKit

struct SceneView: NSViewRepresentable {
    @State var scene: SCNScene?
    @State var overlay: SKScene?

    func makeNSView(context: Context) -> SCNView {
        SCNView()
    }

    func updateNSView(_ nsView: SCNView, context: Context) {
        nsView.scene = scene ?? SCNScene()
        nsView.backgroundColor = .black
        nsView.overlaySKScene = overlay
    }
}
