//
//  MapNeighborhoodsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

import Common

struct MapNeighborhoodsData: Decodable, Equatable {
	struct TypeData: Decodable, Equatable {
		let id: RegionType.ID
		let name: RegionType.Name
	}

	struct RegionData: Decodable, Equatable {
		let id: Region.ID
		let name: Region.Name
	}

	struct NeighborhoodData: Decodable, Equatable {
		let typeId: RegionType.ID
		let regions: [RegionData]
	}

	let types: [TypeData]
	let neighborhoods: [NeighborhoodData]

	func neighbourhood(by id: RegionType.ID) -> NeighborhoodData? {
		neighborhoods.first(where: { $0.typeId == id })
	}
}
