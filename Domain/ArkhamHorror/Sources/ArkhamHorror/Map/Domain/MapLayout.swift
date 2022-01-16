//
//  MapLayout.swift
//  
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

public struct MapLayout {
	public struct NeighborhoodPosition {
		public let x: Int
		public let y: Int
	}

	public struct Neighboarhood {
		public let position: NeighborhoodPosition
		public let typeId: MapRegionType.Id
	}

	public struct Bridge {
		public let from: MapRegionType.Id
		public let to: MapRegionType.Id
		public let edge: MapGeometry.Hexagon.Edge
	}

	public var neighboarhoods: [Neighboarhood]
	public var bridges: [Bridge]

	init(mapData: MapData) {
		neighboarhoods = mapData.layout.tileLayouts.map { tileLayout in
			.init(
				position: .init(x: tileLayout.tile.column, y: tileLayout.tile.row),
				typeId: tileLayout.regionTypeId
			)
		}
		bridges = []
	}
}
