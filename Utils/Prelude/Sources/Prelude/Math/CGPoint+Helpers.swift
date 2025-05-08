//
//  CGPoint+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import CoreGraphics

public extension CGPoint {
    func size() -> CGSize {
        CGSize(width: x, height: y)
    }

    @inlinable
    static func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }

    @inlinable
    static func * (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs.x * rhs.x,
            y: lhs.y * rhs.y
        )
    }

    @inlinable
    static func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        lhs + (-rhs)
    }

    @inlinable
    static prefix func - (_ lhs: CGPoint) -> CGPoint {
        CGPoint(
            x: -lhs.x,
            y: -lhs.y
        )
    }

    @inlinable
    static func + (_ lhs: CGFloat, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs + rhs.x,
            y: lhs + rhs.y
        )
    }

    @inlinable
    static func + (_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
        rhs + lhs
    }

    @inlinable
    static func * (_ lhs: CGFloat, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs * rhs.x,
            y: lhs * rhs.y
        )
    }

    @inlinable
    static func * (_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
        rhs * lhs
    }
}
