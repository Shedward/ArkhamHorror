//
//  MapDataTests.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

import XCTest
@testable import Map
import Yams

final class MapDataTests: XCTestCase {
	func testParsing() throws {
		let mapData = try TestData().mapData()

		let decoder = YAMLDecoder()
		let model = try decoder.decode(MapData.self, from: mapData)

		XCTAssertEqual(model.sityNeighborhoods.types.count, 6)
		XCTAssertEqual(
			model.sityNeighborhoods.types.first,
			.init(id: "northside", name: "Нортсайд")
		)

		XCTAssertEqual(model.sityNeighborhoods.neighborhoods.count, 6)
		XCTAssertEqual(
			model.sityNeighborhoods.neighborhoods.first,
			.init(
				typeId: "northside",
				regions: [
					.init(id: "arkham_advertiser", name: "Аркхэм Адвертайзер"),
					.init(id: "train_station", name: "Вокзал"),
					.init(id: "curriosity_shop", name: "Магазинчик Странностей")
				]
			)
		)

		XCTAssertEqual(model.sityStreets.types.count, 3)
		XCTAssertEqual(
			model.sityStreets.types.first,
			.init(id: "street", name: "Улица")
		)

		XCTAssertEqual(model.sityStreets.streets.count, 7)
		XCTAssertEqual(
			model.sityStreets.streets.first,
			.init(
				id: "park1",
				typeId: "park",
				from: ["arkham_advertiser", "train_station"],
				to: ["arkham_asylum"]
			)
		)

		XCTAssertEqual(model.layout.tileLayouts.count, 6)
		XCTAssertEqual(
			model.layout.tileLayouts.first,
			.init(
				regionTypeId: "northside",
				orientation: .clockwise,
				tile: .init(row: 0, column: 0)
			)
		)
	}
}
