//
//  CGRect+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import CoreGraphics

public extension CGRect {
    static func centeredRect(of size: CGSize) -> CGRect {
        .init(
            origin: -0.5 * size.point(),
            size: size
        )
    }
}
