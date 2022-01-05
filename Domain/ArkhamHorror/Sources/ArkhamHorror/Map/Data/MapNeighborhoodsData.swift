//
//  MapNeighborhoodsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapNeighborhoodsData: Decodable {
	struct TypeData: Decodable {
		let id: String
		let name: String
	}

	struct RegionData: Decodable {
		let id: String
		let name: String
	}

	struct NeighborhoodData: Decodable {
		let typeId: String
		let regions: [RegionData]
	}

	let types: [TypeData]
	let neighborhoods: [NeighborhoodData]
}
