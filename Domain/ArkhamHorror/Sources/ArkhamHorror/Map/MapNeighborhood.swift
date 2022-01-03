//
//  MapNeighborhood.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

struct MapNeighborhood {
	enum IdTag { }
	typealias Id = Tagged<IdTag, String>

	enum NameTag { }
	typealias Name = Tagged<NameTag, String>

	let id: Id
	let name: Name
}

extension MapNeighborhood: Equatable {
	static func == (_ lhs: MapNeighborhood, _ rhs: MapNeighborhood) -> Bool {
		lhs.id == rhs.id
	}
}

extension MapNeighborhood: Decodable {
}
