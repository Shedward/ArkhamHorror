//
//  Map.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Graph

final class Map {
	private var neighborhoods: [MapNeighborhood] = []
	private var regions: [MapRegion] = []
	private var regionsMap: Graph<MapRegion.Id> = Graph()

	func region(by id: MapRegion.Id) -> MapRegion? {
		regions.first { $0.id == id }
	}
}
