//
//  CGEdgeInsets.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import CoreGraphics

public struct CGEdgeInsets {

    public static let zero = CGEdgeInsets()

    public var top: CGFloat
    public var left: CGFloat
    public var bottom: CGFloat
    public var right: CGFloat

    public init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    public init(uniform: CGFloat) {
        self.init(top: uniform, left: uniform, bottom: uniform, right: uniform)
    }

    public init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    public static prefix func - (_ rhs: CGEdgeInsets) -> CGEdgeInsets {
        .init(
            top: -rhs.top,
            left: -rhs.left,
            bottom: -rhs.bottom,
            right: -rhs.right
        )
    }

    public func flipped(by axis: Axis) -> CGEdgeInsets {
        var newInsets = self
        switch axis {
        case .horizontal:
            (newInsets.left, newInsets.right) = (newInsets.right, newInsets.left)
        case .vertical:
            (newInsets.top, newInsets.bottom) = (newInsets.bottom, newInsets.top)
        }
        return newInsets
    }

    public var width: CGFloat {
        left + right
    }

    public var height: CGFloat {
        top + bottom
    }
}

extension CGRect {
    public func inset(by insets: CGEdgeInsets) -> CGRect {
        CGRect(
            x: origin.x - insets.left,
            y: origin.y - insets.top,
            width: size.width + (insets.left + insets.right),
            height: size.height + (insets.top + insets.bottom)
        )
    }
}
