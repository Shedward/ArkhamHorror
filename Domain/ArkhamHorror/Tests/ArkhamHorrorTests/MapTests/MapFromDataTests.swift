//
//  MapFromDataTests.swift
//  
//
//  Created by Vladislav Maltsev on 09.01.2022.
//

import XCTest
@testable import ArkhamHorror

final class MapFromDataTests: XCTestCase {
	func testMapLoading() throws {
		let mapData = try TestData().mapData()

		let decoder = JSONDecoder()
		let mapDataModel = try decoder.decode(MapData.self, from: mapData)

		let map = Map(mapData: mapDataModel)
		XCTAssertEqual(map.region(by: "train_station")?.name, "Вокзал")
	}
}
