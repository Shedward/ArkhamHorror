//
//  SCNQuaternion+Ext.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//

import SceneKit

extension SCNQuaternion {
    init(axis: SCNVector3, radians: Float) {
        let halfAngle = radians * 0.5
        let sinAngle: Float = sin(halfAngle)

        let axis = axis.normalized()

        self.init(
            x: axis.x * sinAngle,
            y: axis.y * sinAngle,
            z: axis.z * sinAngle,
            w: cos(halfAngle)
        )
    }
}
