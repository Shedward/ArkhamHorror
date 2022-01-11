//
//  MapGeometry.swift
//  
//
//  Created by Vladislav Maltsev on 10.01.2022.
//

/// Abstraction for map geometry.
/// Details and resoning: https://www.craft.do/s/gIx3P2RZKDB8Nj
public struct MapGeometry {
	struct HexagonPosition {
		typealias Index = Int
		let x: Index
		let y: Index
	}

	private let sqrt3: Geometry.LengthUnit = 3.squareRoot()

	public let hexagonSize: Geometry.LengthUnit
	public let spacing: Geometry.LengthUnit

	private lazy var tileSize: Geometry.Size = .init(
		width: sqrt3 * hexagonSize,
		height: 2 * hexagonSize
	)

	private let oddRowOffset: Geometry.LengthUnit
	private let tileDeltaX: Geometry.LengthUnit
	private let tileDeltaY: Geometry.LengthUnit
	private let hexagonPointOffsetInTile: [Geometry.Point]

	public init(hexagonSize: Geometry.LengthUnit, spacing: Geometry.LengthUnit) {
		self.hexagonSize = hexagonSize
		self.spacing = spacing

		oddRowOffset = (sqrt3/2) * hexagonSize + (1/2) * spacing
		tileDeltaX = sqrt3 * hexagonSize + spacing
		tileDeltaY = 2 * hexagonSize - (sqrt3/2) * spacing
		hexagonPointOffsetInTile = [
			.init(x: (sqrt3/2) * hexagonSize, y: 0),
			.init(x: sqrt3 * hexagonSize, y: (1/2) * hexagonSize),
			.init(x: sqrt3 * hexagonSize, y: (3/2) * hexagonSize),
			.init(x: (sqrt3/2) * hexagonSize, y: 2 * hexagonSize),
			.init(x: 0, y: (3/2) * hexagonSize),
			.init(x: 0, y: (1/2) * hexagonSize)
		]
	}

	private func rectOriginForHexagon(at hexPosition: HexagonPosition) -> Geometry.Point {
		.init(
			x: oddRowOffset * Geometry.LengthUnit(hexPosition.y % 2)
				+ Geometry.LengthUnit(hexPosition.x) * tileDeltaX,
			y: Geometry.LengthUnit(hexPosition.y) * tileDeltaY
		)
	}

	private func hexagonPoints(at hexPosition: HexagonPosition) -> [Geometry.Point] {
		let tileOrigin = rectOriginForHexagon(at: hexPosition)
		return hexagonPointOffsetInTile.map { offset in tileOrigin + offset }
	}
}
