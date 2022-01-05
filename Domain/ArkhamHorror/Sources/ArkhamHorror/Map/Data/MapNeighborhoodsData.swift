//
//  MapNeighborhoodsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapNeighborhoodsData: Decodable, Equatable {
	struct TypeData: Decodable, Equatable {
		let id: MapRegionType.Id
		let name: MapRegionType.Name
	}

	struct RegionData: Decodable, Equatable {
		let id: MapRegion.Id
		let name: MapRegion.Name
	}

	struct NeighborhoodData: Decodable, Equatable {
		let typeId: MapRegionType.Id
		let regions: [RegionData]
	}

	let types: [TypeData]
	let neighborhoods: [NeighborhoodData]
}
