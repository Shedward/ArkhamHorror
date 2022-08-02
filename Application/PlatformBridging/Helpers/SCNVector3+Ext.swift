//
//  SCNVector3+Ext.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//

import SceneKit

extension SCNVector3 {

    static let xAxis = SCNVector3(1, 0, 0)
    static let yAxis = SCNVector3(0, 1, 0)
    static let zAxis = SCNVector3(0, 0, 1)

    func normalized() -> SCNVector3 {
        let magnitude = ((self.x * self.x) + (self.y * self.y) + (self.z * self.z)).squareRoot()
        return SCNVector3(self.x / magnitude, self.y / magnitude, self.z / magnitude)
    }

    func movedBy(dx: Float = 0, dy: Float = 0, dz: Float = 0) -> SCNVector3 {
        var changed = self
        changed.x += dx
        changed.y += dy
        changed.z += dz
        return changed
    }
}
