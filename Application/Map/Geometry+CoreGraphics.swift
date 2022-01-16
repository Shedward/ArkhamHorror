//
//  Geometry+CoreGraphics.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import ArkhamHorror
import CoreGraphics

extension Geometry.Point {
	init(cgPoint: CGPoint) {
		self.init(
			x: Double(cgPoint.x),
			y: Double(cgPoint.y)
		)
	}

	func toCGPoint() -> CGPoint {
		CGPoint(x: x, y: y)
	}
}
