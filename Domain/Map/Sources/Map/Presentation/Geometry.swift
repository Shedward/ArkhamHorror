//
//  Geometry.swift
//  
//
//  Created by Vladislav Maltsev on 11.01.2022.
//

public enum Geometry {
	public typealias LengthUnit = Double

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
	}

	public struct Size {
		public var width: LengthUnit
		public var height: LengthUnit

		public init(width: LengthUnit, height: LengthUnit) {
			self.width = width
			self.height = height
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

		init(start: Point, end: Point) {
			self.start = start
			self.end = end
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
