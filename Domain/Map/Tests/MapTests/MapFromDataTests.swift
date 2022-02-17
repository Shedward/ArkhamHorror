//
//  MapFromDataTests.swift
//  
//
//  Created by Vladislav Maltsev on 09.01.2022.
//

import XCTest
@testable import Map

final class MapFromDataTests: XCTestCase {
	func testMapLoading() throws {
		let mapData = try TestData().mapData()

		let decoder = JSONDecoder()
		let mapDataModel = try decoder.decode(MapData.self, from: mapData)

		let map = Map(mapData: mapDataModel)
		XCTAssertEqual(map.region(by: "train_station")?.name, "Вокзал")

		XCTAssertFalse(map.isNeighborRegions("curriosity_shop", "independence_square"))
		XCTAssertTrue(map.isNeighborRegions("independence_square", "la_bella_luna"))
		XCTAssertTrue(map.isNeighborRegions("la_bella_luna", "independence_square"))
		XCTAssertTrue(map.isNeighborRegions("arkham_asylum", "la_bella_luna"))
		XCTAssertTrue(map.isNeighborRegions("la_bella_luna", "arkham_asylum"))
		XCTAssertTrue(map.isNeighborRegions("arkham_asylum", "independence_square"))
		XCTAssertTrue(map.isNeighborRegions("independence_square", "arkham_asylum"))

		XCTAssertTrue(map.isNeighborRegions("arkham_asylum", "street2"))
		XCTAssertTrue(map.isNeighborRegions("la_bella_luna", "street2"))
		XCTAssertTrue(map.isNeighborRegions("unvisited_isle", "street2"))
		XCTAssertTrue(map.isNeighborRegions("street2", "arkham_asylum"))
		XCTAssertTrue(map.isNeighborRegions("street2", "la_bella_luna"))
		XCTAssertTrue(map.isNeighborRegions("street2", "unvisited_isle"))
	}
}
