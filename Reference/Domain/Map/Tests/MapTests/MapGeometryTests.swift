//
//  MapGeometryTests.swift
//  
//
//  Created by Vladislav Maltsev on 17.02.2022.
//

import XCTest
import XCTestUtils
@testable import Map

final class MapGeometryTests: XCTestCase {
	func testHexagonGeometry() {
		let geometry = MapGeometry(hexagonSize: 100, spacing: 10)
		let hexagon = geometry.hexagon(at: .init(x: 0, y: 0))

		XCTAssertNear(hexagon.origin, .init(x: 0, y: 0))
		XCTAssertNear(hexagon.center, .init(x: 86.6, y: 100))
		XCTAssertNear(hexagon.point(at: .v0), .init(x: 86.6, y: 0))
		XCTAssertNear(hexagon.point(at: .v1), .init(x: 173.2, y: 50))
		XCTAssertNear(hexagon.point(at: .v2), .init(x: 173.2, y: 150))
		XCTAssertNear(hexagon.point(at: .v3), .init(x: 86.6, y: 200))
		XCTAssertNear(hexagon.point(at: .v4), .init(x: 0, y: 150))
		XCTAssertNear(hexagon.point(at: .v5), .init(x: 0, y: 50))

		let edge0 = hexagon.line(at: .e0)
		XCTAssertNear(edge0.start, .init(x: 86.6, y: 0))
		XCTAssertNear(edge0.end, .init(x: 173.2, y: 50))

		let edge3 = hexagon.line(at: .e0.opposite)
		XCTAssertNear(edge3.start, .init(x: 86.6, y: 200))
		XCTAssertNear(edge3.end, .init(x: 0, y: 150))

		XCTAssertNear(hexagon.region(at: .e0).center, .init(x: 108.2, y: 62.5))
		XCTAssertNear(hexagon.region(at: .e1).center, .init(x: 129.9, y: 100))
		XCTAssertNear(hexagon.region(at: .e2).center, .init(x: 108.2, y: 137.5))
		XCTAssertNear(hexagon.region(at: .e3).center, .init(x: 64.9, y: 137.5))
		XCTAssertNear(hexagon.region(at: .e4).center, .init(x: 43.3, y: 100))
		XCTAssertNear(hexagon.region(at: .e5).center, .init(x: 64.9, y: 62.5))

		let hexagon11 = geometry.hexagon(at: .init(x: 1, y: 1))
		XCTAssertNear(hexagon11.origin, .init(x: 274.8, y: 158.6))
		XCTAssertNear(hexagon11.center, .init(x: 361.4, y: 258.6))
		XCTAssertNear(hexagon11.point(at: .v0), .init(x: 361.4, y: 158.6))
		XCTAssertNear(hexagon11.point(at: .v1), .init(x: 448.0, y: 208.6))
		XCTAssertNear(hexagon11.point(at: .v2), .init(x: 448.0, y: 308.6))
		XCTAssertNear(hexagon11.point(at: .v3), .init(x: 361.4, y: 358.6))
		XCTAssertNear(hexagon11.point(at: .v4), .init(x: 274.8, y: 308.6))
		XCTAssertNear(hexagon11.point(at: .v5), .init(x: 274.8, y: 208.6))
	}

	func testBridgesGeometry() {
		let geometry = MapGeometry(hexagonSize: 100, spacing: 10)

		let bridge = geometry.bridge(from: .init(x: 0, y: 0), to: .init(x: 0, y: 1), fromEdge: .e2)
		XCTAssertNear(bridge.center, .init(x: 132.4, y: 179.3))
		XCTAssertNear(bridge.startLine.start, .init(x: 173.2, y: 150))
		XCTAssertNear(bridge.startLine.end, .init(x: 86.6, y: 200))
		XCTAssertNear(bridge.endLine.start, .init(x: 91.6, y: 208.6))
		XCTAssertNear(bridge.endLine.end, .init(x: 178.2, y: 158.6))

		XCTAssertNear(bridge.region().center, .init(x: 132.4, y: 179.3))
	}

	func testScaledToFitGeometry() {
		let geometry = MapGeometry.scaledToFit(
			size: .init(width: 1000, height: 1000),
			maxPosition: .init(x: 3, y: 2),
			relativeSpacing: 0.5
		)

		XCTAssertNear(geometry.hexagonSize, 104.77)

		let geometryTall = MapGeometry.scaledToFit(
			size: .init(width: 100, height: 1000),
			maxPosition: .init(x: 3, y: 2),
			relativeSpacing: 0.5
		)

		XCTAssertNear(geometryTall.hexagonSize, 10.47)

		let geometryTallOdd = MapGeometry.scaledToFit(
			size: .init(width: 100, height: 1000),
			maxPosition: .init(x: 2, y: 2),
			relativeSpacing: 0.5
		)

		XCTAssertNear(geometryTallOdd.hexagonSize, 16.13)

		let geometryWide = MapGeometry.scaledToFit(
			size: .init(width: 1000, height: 100),
			maxPosition: .init(x: 3, y: 2),
			relativeSpacing: 0.5
		)

		XCTAssertNear(geometryWide.hexagonSize, 17.04)
	}
}

func XCTAssertNear(
	_ lhs: Geometry.Point,
	_ rhs: Geometry.Point,
	maxDistance: Geometry.LengthUnit = 0.1,
	file: StaticString = #filePath,
	line: UInt = #line
) {
	let distance = lhs.distance(to: rhs)
	if distance > maxDistance {
		XCTFail("Point \(lhs) is too far from expected \(rhs) (by \(distance) while expected \(maxDistance)", file: file, line: line)
	}
}
