//
//  MapStreetsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

import Common

struct MapStreetsData: Decodable, Equatable {
	struct TypeData: Decodable, Equatable {
		let id: RegionType.ID
		let name: RegionType.Name
	}

	struct StreetData: Decodable, Equatable {
		let id: Region.ID
		let typeId: RegionType.ID
		let from: [Region.ID]
		let to: [Region.ID]
	}

	let types: [TypeData]
	let streets: [StreetData]
}
