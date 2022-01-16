//
//  MapLayout.swift
//  
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

struct MapLayout {
	struct NeighborhoodPosition {
		let x: Int
		let y: Int
	}

	struct Neighboarhood {
		let position: NeighborhoodPosition
		let typeId: MapRegionType.Id
	}

	struct Bridge {
		let from: MapRegionType.Id
		let to: MapRegionType.Id
		let edge: MapGeometry.Hexagon.Edge
	}
}
