//
//  Geometry+CoreGraphics.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import Map
import CoreGraphics

extension Geometry.Point {
	init(uPoint: UPoint) {
		self.init(
			x: Double(uPoint.x),
			y: Double(uPoint.y)
		)
	}

	func toUPoint() -> UPoint {
		UPoint(x: x, y: y)
	}
}

extension Geometry.Size {
	init(uSize: USize) {
		self.init(
			width: uSize.width,
			height: uSize.height
		)
	}

	func toUSize() -> USize {
		USize(width: width, height: height)
	}
}


extension UBezierPath {
    convenience init(points: [Geometry.Point]) {
        self.init()

        guard let first = points.first else {
            return
        }

        let others = points[1...]

        move(to: first.toUPoint())
        for point in others {
            uAddLine(to: point.toUPoint())
        }
        close()
    }

    convenience init(lineFrom startPoint: UPoint, to endPoint: UPoint) {
        self.init()
        move(to: startPoint)
        uAddLine(to: endPoint)
    }

    private func uAddLine(to point: UPoint) {
        #if os(iOS)
        addLine(to: point)
        #elseif os(macOS)
        line(to: point)
        #endif
    }
}
