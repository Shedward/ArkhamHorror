//
//  Light.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SceneKit
import simd
import DesignSystem

final class Light: SceneObject {
    init(
        at: vector_float3,
        type: SCNLight.LightType,
        color: UColor,
        intencity: CGFloat = 1000,
        temperature: CGFloat = 6500,
        castShadows: Bool = false
    ) {
        let light = SCNLight()
        light.color = color
        light.type = type
        light.intensity = intencity
        light.castsShadow = castShadows
        light.temperature = temperature

        let node = SCNNode()
        node.light = light
        super.init(node: node)
    }
}
