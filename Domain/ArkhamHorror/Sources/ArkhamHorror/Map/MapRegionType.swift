//
//  MapRegionType.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

struct MapRegionType {
	enum IdTag { }
	typealias Id = Tagged<IdTag, String>

	enum NameTag { }
	typealias Name = Tagged<NameTag, String>

	let id: Id
	let name: Name
}

extension MapRegionType: Equatable {
	static func == (_ lhs: MapRegionType, _ rhs: MapRegionType) -> Bool {
		lhs.id == rhs.id
	}
}
