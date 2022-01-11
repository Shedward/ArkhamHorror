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
	}

	public struct Size {
		public var width: LengthUnit
		public var height: LengthUnit

		public init(width: LengthUnit, height: LengthUnit) {
			self.width = width
			self.height = height
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
