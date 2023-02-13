//
//  CGSize+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import CoreGraphics

public extension CGSize {

    init(uniform: CGFloat) {
        self.init(width: uniform, height: uniform)
    }

    func point() -> CGPoint {
        CGPoint(x: width, y: height)
    }

    func absoluteAnchor(for anchor: CGPoint) -> CGPoint {
        point() * anchor
    }
}
