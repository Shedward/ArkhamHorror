//
//  SCNVector3+Ext.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 02.08.2022.
//

import SceneKit
import DesignSystem

extension SCNVector3 {

    static let origin = SCNVector3(0, 0, 0)
    static let xAxis = SCNVector3(1, 0, 0)
    static let yAxis = SCNVector3(0, 1, 0)
    static let zAxis = SCNVector3(0, 0, 1)

    static func uniformScale(_ s: UFloat) -> SCNVector3 {
        SCNVector3(s, s, s)
    }

    func normalized() -> SCNVector3 {
        let magnitude = ((self.x * self.x) + (self.y * self.y) + (self.z * self.z)).squareRoot()
        return SCNVector3(self.x / magnitude, self.y / magnitude, self.z / magnitude)
    }

    func movedBy(dx: UFloat = 0, dy: UFloat = 0, dz: UFloat = 0) -> SCNVector3 {
        var changed = self
        changed.x += dx
        changed.y += dy
        changed.z += dz
        return changed
    }

    #if os(iOS)
    var xy: UPoint {
        get {
            UPoint(x: CGFloat(x), y: CGFloat(y))
        }
        set {
            x = Float(newValue.x)
            y = Float(newValue.y)
        }
    }
    #elseif os(macOS)
    var xy: UPoint {
        get {
            UPoint(x: x, y: y)
        }
        set {
            x = newValue.x
            y = newValue.y
        }
    }
    #endif
}
