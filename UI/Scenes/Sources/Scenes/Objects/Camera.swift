//
//  Camera.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SceneKit
import simd

final class Camera: SceneObject {
    init(at position: vector_float3, lookingAt: vector_float3) {
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 4
        camera.fieldOfView = 20

        let node = SCNNode()
        node.camera = camera
        node.simdPosition = position
        node.simdLook(at: lookingAt)
        super.init(node: node)
    }
}
