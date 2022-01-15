//
//  MapGeometry.swift
//  
//
//  Created by Vladislav Maltsev on 10.01.2022.
//

private let sqrt3: Geometry.LengthUnit = 3.squareRoot()

/// Abstraction for map geometry.
/// Details and resoning: https://www.craft.do/s/gIx3P2RZKDB8Nj
public struct MapGeometry {
	struct HexagonPosition {
		typealias Index = Int
		let x: Index
		let y: Index
	}

	struct Hexagon {
		enum Point: Int {
			case p0 = 0
			case p1 = 1
			case p2 = 2
			case p3 = 3
			case p4 = 4
			case p5 = 5

			func next() -> Point {
				let nextIndex = (rawValue + 1) % 6
				guard let nextPoint = Point(rawValue: nextIndex) else {
					fatalError("Impossible value \(nextIndex) for next point.")
				}
				return nextPoint
			}

			func opposite() -> Point {
				let oppositeIndex = (rawValue + 3) % 6
				guard let oppositePoint = Point(rawValue: oppositeIndex) else {
					fatalError("Impossible value \(oppositeIndex) for opposite point.")
				}
				return oppositePoint
			}
		}

		enum Edge: Int {
			case e0 = 0
			case e1 = 1
			case e2 = 2
			case e3 = 3
			case e4 = 4
			case e5 = 5
		}

		let origin: Geometry.Point
		let size: Geometry.LengthUnit
		let center: Geometry.Point
		let allPoints: [Geometry.Point]

		init(origin: Geometry.Point, size: Geometry.LengthUnit) {
			self.origin = origin
			self.size = size

			let pointOffsets: [Geometry.Point] = [
				.init(x: (sqrt3/2) * size, y: 0),
				.init(x: sqrt3 * size, y: (1/2) * size),
				.init(x: sqrt3 * size, y: (3/2) * size),
				.init(x: (sqrt3/2) * size, y: 2 * size),
				.init(x: 0, y: (3/2) * size),
				.init(x: 0, y: (1/2) * size)
			]
			points = pointOffsets.map { origin + $0 }

			let centerOffset = Geometry.Point(
				x: (sqrt3/2) * size,
				y: size
			)
			center = origin + centerOffset
		}

		func point(at point: Point) -> Geometry.Point {
			allPoints[point.rawValue]
		}

		func
	}

	struct Bridge {
		init(from fromHex: Hexagon, to toHex: Hexagon, fromEdge: Hexagon.Edge) {

		}
	}

	public let hexagonSize: Geometry.LengthUnit
	public let spacing: Geometry.LengthUnit

	private lazy var tileSize: Geometry.Size = .init(
		width: sqrt3 * hexagonSize,
		height: 2 * hexagonSize
	)

	private let oddRowOffset: Geometry.LengthUnit
	private let tileDeltaX: Geometry.LengthUnit
	private let tileDeltaY: Geometry.LengthUnit

	public init(hexagonSize: Geometry.LengthUnit, spacing: Geometry.LengthUnit) {
		self.hexagonSize = hexagonSize
		self.spacing = spacing

		oddRowOffset = (sqrt3/2) * hexagonSize + (1/2) * spacing
		tileDeltaX = sqrt3 * hexagonSize + spacing
		tileDeltaY = 2 * hexagonSize - (sqrt3/2) * spacing
	}

	private func rectOriginForHexagon(at hexPosition: HexagonPosition) -> Geometry.Point {
		.init(
			x: oddRowOffset * Geometry.LengthUnit(hexPosition.y % 2)
				+ Geometry.LengthUnit(hexPosition.x) * tileDeltaX,
			y: Geometry.LengthUnit(hexPosition.y) * tileDeltaY
		)
	}

	private func hexagon(at hexPosition: HexagonPosition) -> Hexagon {
		let origin = rectOriginForHexagon(at: hexPosition)
		return .init(origin: origin, size: hexagonSize)
	}
}
