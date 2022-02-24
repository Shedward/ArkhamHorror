//
//  MapStreetsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

import Common

struct MapStreetsData: Decodable, Equatable {
	struct TypeData: Decodable, Equatable {
		let id: RegionType.Id
		let name: RegionType.Name
	}

	struct StreetData: Decodable, Equatable {
		let id: Region.Id
		let typeId: RegionType.Id
		let from: [Region.Id]
		let to: [Region.Id]
	}

	let types: [TypeData]
	let streets: [StreetData]
}
