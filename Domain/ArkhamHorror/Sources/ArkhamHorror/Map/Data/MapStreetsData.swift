//
//  MapStreetsData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapStreetsData: Decodable {
	struct TypeData: Decodable {
		let id: String
		let name: String
	}

	struct StreetData: Decodable {
		let id: String
		let typeId: String
		let from: [String]
		let to: [String]
	}

	let types: [TypeData]
	let streets: [StreetData]
}
