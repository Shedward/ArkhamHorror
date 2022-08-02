//
//  SceneViewWrapper.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//

import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
    let scene: SCNScene

    func makeUIView(context: Context) -> some UIView {
        let sceneView = SCNView()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true
        return sceneView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
