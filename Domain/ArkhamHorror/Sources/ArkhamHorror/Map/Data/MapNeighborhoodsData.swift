//
//  MapNeighborhoodsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapNeighborhoodsData: Decodable, Equatable {
	struct TypeData: Decodable, Equatable {
		let id: String
		let name: String
	}

	struct RegionData: Decodable, Equatable {
		let id: String
		let name: String
	}

	struct NeighborhoodData: Decodable, Equatable {
		let typeId: String
		let regions: [RegionData]
	}

	let types: [TypeData]
	let neighborhoods: [NeighborhoodData]
}
