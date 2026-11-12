//
//  Axis.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import CoreGraphics

public enum Axis {
    case horizontal
    case vertical

    @inlinable
    var another: Axis {
        switch self {
        case .horizontal:
            return .vertical
        case .vertical:
            return .horizontal
        }
    }
}

extension CGPoint {
    @inlinable
    public subscript(axis axis: Axis) -> CGFloat {
        get {
            switch axis {
            case .horizontal:
                return x
            case .vertical:
                return y
            }
        }
        set {
            switch axis {
            case .horizontal:
                return x = newValue
            case .vertical:
                return y = newValue
            }
        }
    }
}

extension CGSize {
    @inlinable
    public subscript(axis axis: Axis) -> CGFloat {
        get {
            switch axis {
            case .horizontal:
                return width
            case .vertical:
                return height
            }
        }
        set {
            switch axis {
            case .horizontal:
                return width = newValue
            case .vertical:
                return height = newValue
            }
        }
    }
}
