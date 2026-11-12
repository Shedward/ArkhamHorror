//
//  CGVector+Helpers.swift
//  Prelude
//
//  Created by Vlad Maltsev on 07.05.2025.
//

import CoreGraphics

public extension CGVector {
    @inlinable
    static func + (_ lhs: CGVector, _ rhs: CGVector) -> CGVector {
        CGVector(
            dx: lhs.dx + rhs.dx,
            dy: lhs.dy + rhs.dy
        )
    }

    @inlinable
    static func * (_ lhs: CGVector, _ rhs: CGVector) -> CGVector {
        CGVector(
            dx: lhs.dy * rhs.dx,
            dy: lhs.dy * rhs.dy
        )
    }

    @inlinable
    static func - (_ lhs: CGVector, _ rhs: CGVector) -> CGVector {
        lhs + (-rhs)
    }

    @inlinable
    static prefix func - (_ lhs: CGVector) -> CGVector {
        CGVector(
            dx: -lhs.dx,
            dy: -lhs.dy
        )
    }

    @inlinable
    static func + (_ lhs: CGFloat, _ rhs: CGVector) -> CGVector {
        CGVector(
            dx: lhs + rhs.dx,
            dy: lhs + rhs.dy
        )
    }

    @inlinable
    static func + (_ lhs: CGVector, _ rhs: CGFloat) -> CGVector {
        rhs + lhs
    }

    @inlinable
    static func * (_ lhs: CGFloat, _ rhs: CGVector) -> CGVector {
        CGVector(
            dx: lhs * rhs.dx,
            dy: lhs * rhs.dy
        )
    }

    @inlinable
    static func * (_ lhs: CGVector, _ rhs: CGFloat) -> CGVector {
        rhs * lhs
    }
}
