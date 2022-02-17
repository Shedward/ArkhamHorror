//
//  Geometry+CoreGraphics.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import Map
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

extension Geometry.Size {
	init(cgSize: CGSize) {
		self.init(
			width: cgSize.width,
			height: cgSize.height
		)
	}

	func toCGSize() -> CGSize {
		CGSize(width: width, height: height)
	}
}
