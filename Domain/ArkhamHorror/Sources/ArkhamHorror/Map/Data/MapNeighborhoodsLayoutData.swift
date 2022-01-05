//
//  MapNeighborhoodsLayoutData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapNeighborhoodsLayoutData: Decodable {
	struct TileLayoutData: Decodable {
		enum Orientation: String, Decodable {
			case clockwise = "clockwise"
			case counterclockwise = "counterclockwise"
		}

		struct TileLocation: Decodable {
			let row: Int
			let column: Int
		}

		let regionTypeId: String
		let orientation: Orientation
		let tile: TileLocation
	}

	let tileLayouts: [TileLayoutData]

	init(tileLayouts: [TileLayoutData]) {
		self.tileLayouts = tileLayouts
	}

	init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		var tileLayouts: [TileLayoutData] = []
		while !container.isAtEnd {
			let tileLayout = try container.decode(TileLayoutData.self)
			tileLayouts.append(tileLayout)
		}

		self.init(tileLayouts: tileLayouts)
	}
}
