//
//  MapGeometry.swift
//  
//
//  Created by Vladislav Maltsev on 10.01.2022.
//

private let sqrt3: Geometry.LengthUnit = 3.squareRoot()

/// Abstraction for map geometry.
/// Details and reasoning: https://www.craft.do/s/gIx3P2RZKDB8Nj
public struct MapGeometry {
	public struct HexagonPosition {
		public typealias Index = Int

		public let x: Index
		public let y: Index

		public init(x: Index, y: Index) {
			self.x = x
			self.y = y
		}
	}

	public struct Hexagon {
		public enum Vertex: Int {
			case v0 = 0
			case v1 = 1
			case v2 = 2
			case v3 = 3
			case v4 = 4
			case v5 = 5

			public static let all: [Vertex] = [.v0, .v1, .v2, .v3, .v4, .v5]

			public var opposite: Vertex {
				next(step: 3)
			}

			public var next: Vertex {
				next(step: 1)
			}

			public var previous: Vertex {
				next(step: -1)
			}

			private func next(step: Int) -> Vertex {
				let nextIndex = (rawValue + step) % Self.all.count
				guard let nextPoint = Vertex(rawValue: nextIndex) else {
					fatalError("Impossible value \(nextIndex) for next \(step) point from \(self).")
				}
				return nextPoint
			}
		}

		public enum Edge: Int {
			case e0 = 0
			case e1 = 1
			case e2 = 2
			case e3 = 3
			case e4 = 4
			case e5 = 5

			public static let all: [Edge] = [.e0, .e1, .e2, .e3, .e4, .e5]

			public var opposite: Edge {
				next(step: 3)
			}

			public var next: Edge {
				next(step: 1)
			}

			public var prevoius: Edge {
				next(step: -1)
			}

			public var startVertex: Vertex {
				guard let vertex = Vertex(rawValue: rawValue) else {
					fatalError("Impossible value for vertex \(rawValue)")
				}
				return vertex
			}

			public var endVertex: Vertex {
				startVertex.next
			}

			private func next(step: Int) -> Edge {
				var nextIndex = (rawValue + step) % Self.all.count
                if nextIndex < 0 {
                    nextIndex = Self.all.count + nextIndex
                }
				guard let nextEdge = Edge(rawValue: nextIndex) else {
					fatalError("Impossible value \(nextIndex) for next \(step) edge from \(self).")
				}
				return nextEdge
			}
		}

		public let origin: Geometry.Point
		public let edgeLength: Geometry.LengthUnit
		public let center: Geometry.Point
        public let size: Geometry.Size
		public let allPoints: [Geometry.Point]

		public init(origin: Geometry.Point, edgeLength: Geometry.LengthUnit) {
			self.origin = origin
			self.edgeLength = edgeLength

			let pointOffsets: [Geometry.Point] = [
				.init(x: (sqrt3/2) * edgeLength, y: 0),
				.init(x: sqrt3 * edgeLength, y: (1/2) * edgeLength),
				.init(x: sqrt3 * edgeLength, y: (3/2) * edgeLength),
				.init(x: (sqrt3/2) * edgeLength, y: 2 * edgeLength),
				.init(x: 0, y: (3/2) * edgeLength),
				.init(x: 0, y: (1/2) * edgeLength)
			]
			allPoints = pointOffsets.map { origin + $0 }

			let centerOffset = Geometry.Point(
				x: (sqrt3/2) * edgeLength,
				y: edgeLength
			)
			center = origin + centerOffset
            size = (centerOffset + centerOffset).toSize()
		}

		public func point(at vertex: Vertex) -> Geometry.Point {
			allPoints[vertex.rawValue]
		}

		public func line(at edge: Edge) -> Geometry.Line {
			Geometry.Line(
				start: point(at: edge.startVertex),
				end: point(at: edge.endVertex)
			)
		}

		public func region(at edge: Edge) -> Region {
			let edgeLine = line(at: edge)
			let regionCenter = Geometry.Line(start: center, end: edgeLine.middle).middle
            let border: [Geometry.Point] = [
                center,
                line(at: edge.prevoius).middle,
                edgeLine.start,
                edgeLine.end,
                line(at: edge.next).middle
            ]
            return Region(center: regionCenter, width: (sqrt3/4) * edgeLength, border: border)
		}
	}

	public struct Bridge {
		public let startLine: Geometry.Line
		public let endLine: Geometry.Line
		public var center: Geometry.Point {
			Geometry.Line(start: startLine.middle, end: endLine.middle).middle
		}

		public init(from fromHex: Hexagon, to toHex: Hexagon, fromEdge: Hexagon.Edge) {
			startLine = fromHex.line(at: fromEdge)
			endLine = toHex.line(at: fromEdge.opposite)
		}

		public func region() -> Region {
			let centerLine = Geometry.Line(start: startLine.middle, end: endLine.middle)
			let minMedianLength = min(startLine.length, centerLine.length)
			let width = minMedianLength / 2
            let border: [Geometry.Point] = [
                startLine.start,
                startLine.end,
                endLine.start,
                endLine.end
            ]
            return .init(center: centerLine.middle, width: width, border: border)
		}
	}

	public struct Region {
		public let center: Geometry.Point
		public let width: Geometry.LengthUnit
        public let border: [Geometry.Point]
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
		tileDeltaY = (3/2) * hexagonSize + (sqrt3/2) * spacing
	}

	public static let tileAspectRatio = sqrt3 / 2

	public static func scaledToFit(
		size: Geometry.Size,
		maxPosition: HexagonPosition,
		relativeSpacing: Geometry.LengthUnit
	) -> MapGeometry {
		let mdx = sqrt3 + relativeSpacing
		let xCount = Geometry.LengthUnit(maxPosition.x + 1)
		let oddRowOffsetM: Geometry.LengthUnit
		if maxPosition.x % 2 == 0 {
			oddRowOffsetM = 0
		} else {
			oddRowOffsetM = sqrt3/2.0 + 0.5 * relativeSpacing
		}
		let extraWidthM = relativeSpacing
		let idealSizeForWidth = size.width / (mdx * xCount + oddRowOffsetM - extraWidthM)
		let mdy = 1.5 + sqrt3/2.0 * relativeSpacing
		let yCount = Geometry.LengthUnit(maxPosition.y + 1)
		let extraHeightM = -0.5 + sqrt3/2.0 * relativeSpacing
		let idealSizeForHeight = size.height / (mdy * yCount - extraHeightM)

		let size = min(idealSizeForWidth, idealSizeForHeight)
		let spacing = relativeSpacing * size
		return .init(hexagonSize: size, spacing: spacing)
	}

	public func origin(at hexPosition: HexagonPosition) -> Geometry.Point {
		.init(
			x: oddRowOffset * Geometry.LengthUnit(hexPosition.y % 2)
				+ Geometry.LengthUnit(hexPosition.x) * tileDeltaX,
			y: Geometry.LengthUnit(hexPosition.y) * tileDeltaY
		)
	}

    public func endPoint(for maxPosition: HexagonPosition) -> Geometry.Point {
        let lastHexagon = hexagon(at: maxPosition)
        return lastHexagon.origin + lastHexagon.size.toPoint()
    }

	public func hexagon(at hexPosition: HexagonPosition) -> Hexagon {
        let origin = self.origin(at: hexPosition)
        return .init(origin: origin, edgeLength: hexagonSize)
	}

    public func hexagon() -> Hexagon {
        return .init(origin: .init(x: 0, y: 0), edgeLength: hexagonSize)
    }

	public func bridge(
		from fromHexPosition: HexagonPosition,
		to toHexPosition: HexagonPosition,
		fromEdge: Hexagon.Edge
	) -> Bridge {
		.init(
			from: hexagon(at: fromHexPosition),
			to: hexagon(at: toHexPosition),
			fromEdge: fromEdge
		)
	}
}
