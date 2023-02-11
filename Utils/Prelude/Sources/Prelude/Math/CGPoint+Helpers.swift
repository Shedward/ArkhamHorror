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

    static func + (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }

    static func * (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs.x * rhs.x,
            y: lhs.y * rhs.y
        )
    }

    static func - (_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        lhs + (-rhs)
    }

    static prefix func - (_ lhs: CGPoint) -> CGPoint {
        CGPoint(
            x: -lhs.x,
            y: -lhs.y
        )
    }

    static func + (_ lhs: CGFloat, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs + rhs.x,
            y: lhs + rhs.y
        )
    }

    static func + (_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
        rhs + lhs
    }

    static func * (_ lhs: CGFloat, _ rhs: CGPoint) -> CGPoint {
        CGPoint(
            x: lhs * rhs.x,
            y: lhs * rhs.y
        )
    }

    static func * (_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
        rhs * lhs
    }
}
