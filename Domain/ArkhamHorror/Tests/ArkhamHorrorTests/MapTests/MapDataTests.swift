//
//  MapDataTests.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

import XCTest
@testable import ArkhamHorror

final class MapDataTests: XCTestCase {
	func testParsing() throws {
		let bundle = Bundle.module
		let resourceUrl = try XCTUnwrap(bundle.resourcePath.map(URL.init(fileURLWithPath:)))
		let mapUrl = resourceUrl.appendingPathComponent("TestData/map.json")
		let data = try Data(contentsOf: mapUrl)

		let decoder = JSONDecoder()
		let model = try decoder.decode(MapData.self, from: data)
		XCTAssertEqual(model.sityNeighborhoods.neighborhoods.count, 5)
	}
}
