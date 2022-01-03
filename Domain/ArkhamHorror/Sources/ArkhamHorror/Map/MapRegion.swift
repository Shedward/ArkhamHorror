//
//  MapTile.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

final class MapRegion: Equatable {
	enum IdTag {}
	typealias Id = Tagged<IdTag, String>
	enum NameTag {}
	typealias Name = Tagged<NameTag, String>

	let id: Id
	let name: Name
	let neighborhoodId: MapNeighborhood.Id

	init(
		id: Id,
		name: Name,
		neighborhoodId: MapNeighborhood.Id
	) {
		self.id = id
		self.name = name
		self.neighborhoodId = neighborhoodId
	}

	static func == (_ lhs: MapRegion, _ rhs: MapRegion) -> Bool {
		lhs.id == rhs.id
	}
}
