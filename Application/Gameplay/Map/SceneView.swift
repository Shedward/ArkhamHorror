//
//  SceneViewWrapper.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//

import SwiftUI
import SceneKit

#if os(iOS)
struct SceneView: UIViewRepresentable {
    let scene: SCNScene

    func makeUIView(context: Context) -> some UView {
        let sceneView = SCNView()
        sceneView.scene = scene
        configureSceneView(sceneView)
        return sceneView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
#elseif os(macOS)
struct SceneView: NSViewRepresentable {
    let scene: SCNScene

    func makeNSView(context: Context) -> some NSView {
        let sceneView = SCNView()
        sceneView.scene = scene
        configureSceneView(sceneView)
        return sceneView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
    }
}
#endif

private func configureSceneView(_ sceneView: SCNView) {
    sceneView.allowsCameraControl = true
}
