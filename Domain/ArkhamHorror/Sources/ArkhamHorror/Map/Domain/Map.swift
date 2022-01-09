//
//  Map.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Graph

final class Map {
	private var neighborhoods: [MapRegionType] = []
	private var streetTypes: [MapRegionType] = []
	private var regions: [MapRegion] = []
	private var streets: [MapRegion] = []
	private var regionsMap: Graph<MapRegion.Id> = Graph()

	init(mapData: MapData) {
		mapData.sityNeighborhoods.types.forEach { type  in
			neighborhoods.append(.init(id: type.id, name: type.name))
		}
		mapData.sityNeighborhoods.neighborhoods.forEach { neighborhood in
			neighborhood.regions.forEach { region in
				regions.append(.init(id: region.id, name: region.name, typeId: neighborhood.typeId))
			}
			let regionIds = neighborhood.regions.map { $0.id }
			GraphBuilder(graph: regionsMap).createBidirectionalRing(regionIds)
		}
		mapData.sityStreets.types.forEach { streetType in
			streetTypes.append(.init(id: streetType.id, name: streetType.name))
		}
		mapData.sityStreets.streets.forEach { street in
			let streetRegion = MapRegion(id: street.id, name: nil, typeId: street.typeId)
			GraphBuilder(graph: regionsMap).createBridge(streetRegion.id, from: street.from, to: street.to)
		}
	}

	func region(by id: MapRegion.Id) -> MapRegion? {
		regions.first { $0.id == id }
	}
}
