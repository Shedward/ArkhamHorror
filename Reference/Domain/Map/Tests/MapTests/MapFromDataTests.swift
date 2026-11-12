//
//  MapFromDataTests.swift
//  
//
//  Created by Vladislav Maltsev on 09.01.2022.
//

import XCTest
import Yams
@testable import Map

final class MapFromDataTests: XCTestCase {
	func testMapLoading() throws {
		let mapData = try TestData().mapData()

		let map = try Map(data: mapData)

		XCTAssertEqual(map.region(by: "train_station")?.name, "Вокзал")

		XCTAssertFalse(map.isNeighborRegions("curriosity_shop", "indep_square"))
		XCTAssertTrue(map.isNeighborRegions("indep_square", "la_bella_luna"))
		XCTAssertTrue(map.isNeighborRegions("la_bella_luna", "indep_square"))
		XCTAssertTrue(map.isNeighborRegions("arkham_asylum", "la_bella_luna"))
		XCTAssertTrue(map.isNeighborRegions("la_bella_luna", "arkham_asylum"))
		XCTAssertTrue(map.isNeighborRegions("arkham_asylum", "indep_square"))
		XCTAssertTrue(map.isNeighborRegions("indep_square", "arkham_asylum"))

		XCTAssertTrue(map.isNeighborRegions("arkham_asylum", "street2"))
		XCTAssertTrue(map.isNeighborRegions("la_bella_luna", "street2"))
		XCTAssertTrue(map.isNeighborRegions("unvisited_isle", "street2"))
		XCTAssertTrue(map.isNeighborRegions("street2", "arkham_asylum"))
		XCTAssertTrue(map.isNeighborRegions("street2", "la_bella_luna"))
		XCTAssertTrue(map.isNeighborRegions("street2", "unvisited_isle"))
	}
}
