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


extension UBezierPath {
    convenience init(points: [Geometry.Point]) {
        self.init()

        guard let first = points.first else {
            return
        }

        let others = points[1...]

        move(to: first.toCGPoint())
        for point in others {
            addLine(to: point.toCGPoint())
        }
        close()
    }

    convenience init(lineFrom startPoint: CGPoint, to endPoint: CGPoint) {
        self.init()
        move(to: startPoint)
        addLine(to: endPoint)
    }
}
