//
//  Player.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SceneKit
import Prelude
import DesignSystem
import ArkhamHorror

public final class Player: SceneObject {
    static let regionHeight: Float = 0.2

    public let id: ArkhamHorror.Player.ID

    public init(id: ArkhamHorror.Player.ID, color: UColor) {
        self.id = id
        let geometry = SCNPyramid(width: 0.125, height: 0.5, length: 0.25)
        geometry.materials = [MapRegion.material(color: color)]

        let light = SCNLight()
        light.type = .omni
        light.color = color
        light.intensity = 3000
        light.castsShadow = true

        let node = SCNNode()
        node.light = light
        node.geometry = geometry
        node.orientation = .init(axis: .xAxis, radians: .pi2)
        node.simdPosition.z = MapRegion.height + 0.05

        super.init(node: node)
    }
}
