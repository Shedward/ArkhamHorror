//
//  Camera.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SceneKit
import simd

final class OrbitingCamera: SceneObject {
    let orbit: SCNNode = SCNNode()

    init(around: vector_float3, position: vector_float3) {
        let camera = SCNCamera()
        camera.name = "Orbital Camera"
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 4
        camera.fieldOfView = 20

        let node = SCNNode()
        node.camera = camera
        node.simdPosition = position
        node.simdLook(at: .zero)

        orbit.simdPosition = around
        orbit.addChildNode(node)

        super.init(node: orbit)
    }

    func look(at point: vector_float3) {
        orbit.simdLook(at: point)
    }

    func orbitX(_ angle: Float) {
        orbit.simdEulerAngles.x = angle
    }
}
