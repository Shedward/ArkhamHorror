//
//  MapStreetsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapStreetsData: Decodable, Equatable {
	struct TypeData: Decodable, Equatable {
		let id: MapRegionType.Id
		let name: MapRegionType.Name
	}

	struct StreetData: Decodable, Equatable {
		let id: MapRegion.Id
		let typeId: MapRegionType.Id
		let from: [MapRegion.Id]
		let to: [MapRegion.Id]
	}

	let types: [TypeData]
	let streets: [StreetData]
}
