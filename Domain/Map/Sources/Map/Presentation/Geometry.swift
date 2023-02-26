//
//  Geometry.swift
//  
//
//  Created by Vladislav Maltsev on 11.01.2022.
//

import Darwin
import simd

public enum Geometry {
	public typealias LengthUnit = Float
    public typealias AngleUnit = Float

	public struct Point {
		public var x: LengthUnit
		public var y: LengthUnit

		public init(x: LengthUnit, y: LengthUnit) {
			self.x = x
			self.y = y
		}

		static func + (_ lhs: Point, _ rhs: Point) -> Point {
			.init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
		}

		static prefix func - (_ rhs: Point) -> Point {
			.init(x: -rhs.x, y: -rhs.y)
		}

		static func - (_ lhs: Point, rhs: Point) -> Point {
			lhs + (-rhs)
		}

		public func distance(to anotherPoint: Point) -> LengthUnit {
			Line(start: self, end: anotherPoint).length
		}

        public func toSize() -> Size {
            .init(width: x, height: y)
        }

        public func toVec3() -> vector_float3 {
            .init(x: x, y: y, z: 0)
        }
	}

	public struct Size {
		public var width: LengthUnit
		public var height: LengthUnit

        public var maxDimention: LengthUnit {
            max(width, height)
        }

		public init(width: LengthUnit, height: LengthUnit) {
			self.width = width
			self.height = height
		}

        public func toPoint() -> Point {
            .init(x: width, y: height)
        }
	}

	public struct Line {
		public var start: Point
		public var end: Point

		public var middle: Point {
			.init(
				x: (start.x + end.x) / 2,
				y: (start.y + end.y) / 2
			)
		}

		public var length: LengthUnit {
			let delta = end - start
			return (delta.x * delta.x + delta.y * delta.y).squareRoot()
		}

        public var angle: AngleUnit {
            let dp = end - start
            return atan2(dp.y, dp.x)
        }

		init(start: Point, end: Point) {
			self.start = start
			self.end = end
		}

        func inverted() -> Line {
            .init(start: end, end: start)
        }

        func isUsableForText() -> Bool {
            let xAxisSign = cos(angle)
            if xAxisSign > 0 {
                return true
            } else if xAxisSign < 0 {
                return false
            } else {
                if sin(angle) > 0 {
                    return true
                } else {
                    return false
                }
            }
        }
	}

	public struct Rect {
		public var origin: Point
		public var size: Size

		init(origin: Point, size: Size) {
			self.origin = origin
			self.size = size
		}
	}
}
