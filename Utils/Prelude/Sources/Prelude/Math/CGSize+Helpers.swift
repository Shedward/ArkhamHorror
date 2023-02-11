//
//  CGSize+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import CoreGraphics

public extension CGSize {
    func point() -> CGPoint {
        CGPoint(x: width, y: height)
    }
}
