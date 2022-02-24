//
//  MapLayout.swift
//  
//
//  Created by Vladislav Maltsev on 16.01.2022.
//

import Common

public struct MapLayout {
	public struct NeighborhoodPosition {
		public let x: Int
		public let y: Int

		public func toHexagonPosition() -> MapGeometry.HexagonPosition {
			.init(x: x, y: y)
		}
	}

	public enum RegionOrientation {
		case clockwise
		case counterclockwise

		init(from data: MapNeighborhoodsLayoutData.TileLayoutData.Orientation) {
			switch data {
			case .clockwise:
				self = .clockwise
			case .counterclockwise:
				self = .counterclockwise
			}
		}
	}

	public struct Neighboarhood {
		public let position: NeighborhoodPosition
		public let typeId: RegionType.Id
		public let regionOrientation: RegionOrientation
		public let regions: [Region.Id]

		public func edge(for regionId: Region.Id) -> MapGeometry.Hexagon.Edge? {
			guard let regionIndex = regions.firstIndex(of: regionId) else {
				return nil
			}

			return edge(at: regionIndex)
		}

		public func edge(for regions: [Region.Id]) -> MapGeometry.Hexagon.Edge? {
			switch regions.count {
			case 0:
				return nil
			case 1:
				return edge(for: regions[0])
			case 2:
				return edgeBetween(firstRegion: regions[0], secondRegion: regions[1])
			default:
				return nil
			}
		}

		public func borderEdges() -> [MapGeometry.Hexagon.Edge] {
			switch regionOrientation {
			case .clockwise:
				return [.e1, .e3, .e5]
			case .counterclockwise:
				return [.e0, .e2, .e4]
			}
		}

		private func edge(at index: Int) -> MapGeometry.Hexagon.Edge? {
			let edges: [MapGeometry.Hexagon.Edge]
			switch regionOrientation {
			case .clockwise:
				edges = [.e0, .e2, .e4]
			case .counterclockwise:
				edges = [.e5, .e3, .e1]
			}

			guard edges.indices.contains(index) else {
				return nil
			}
			return edges[index]
		}

		private func edgeBetween(firstRegion: Region.Id, secondRegion: Region.Id) -> MapGeometry.Hexagon.Edge? {
			guard let firstEdge = regions.firstIndex(of: firstRegion) else { return nil }
			guard let secondEdge = regions.firstIndex(of: secondRegion) else { return nil }

			let betweenEdgeIndex: Int
			switch (firstEdge, secondEdge) {
			case (0, 1), (1, 0):
				betweenEdgeIndex = 0
			case (1, 2), (2, 1):
				betweenEdgeIndex = 1
			case (2, 0), (0, 2):
				betweenEdgeIndex = 2
			default:
				return nil
			}

			let betweenEdges: [MapGeometry.Hexagon.Edge]
			switch regionOrientation {
			case .clockwise:
				betweenEdges = [.e1, .e3, .e5]
			case .counterclockwise:
				betweenEdges = [.e4, .e2, .e0]
			}

			return betweenEdges[betweenEdgeIndex]
		}
	}

	public struct Street {
		public struct Edge {
			public let regionType: RegionType.Id
			public let edge: MapGeometry.Hexagon.Edge
			public let position: NeighborhoodPosition
		}

		public let regionId: Region.Id
		public let typeId: RegionType.Id
		public let from: Edge
		public let to: Edge
	}

	public var neighboarhoods: [Neighboarhood]
	public var streets: [Street]

	init(mapData: MapData) {
		let neighboarhoods = mapData.layout.tileLayouts.compactMap { Self.neighbourhood(from: $0, mapData: mapData) }
		let streets = mapData.sityStreets.streets.compactMap { Self.street(from: $0, neighbourhoods: neighboarhoods) }

		self.neighboarhoods = neighboarhoods
		self.streets = streets
	}

	private static func neighbourhood(from tileLayout: MapNeighborhoodsLayoutData.TileLayoutData, mapData: MapData) -> Neighboarhood? {
		guard let neighbourhood = mapData.sityNeighborhoods.neighbourhood(by: tileLayout.regionTypeId) else {
			return nil
		}

		return Neighboarhood(
			position: .init(x: tileLayout.tile.column, y: tileLayout.tile.row),
			typeId: tileLayout.regionTypeId,
			regionOrientation: .init(from: tileLayout.orientation),
			regions: neighbourhood.regions.map { $0.id }
		)
	}

	private static func street(from street: MapStreetsData.StreetData, neighbourhoods: [Neighboarhood]) -> Street? {
		var fromNeighbourhood: Neighboarhood?
		var fromEdge: MapGeometry.Hexagon.Edge?
		var toNeighbourhood: Neighboarhood?
		var toEdge: MapGeometry.Hexagon.Edge?

		for neighboarhood in neighbourhoods {
			if let foundFromEdge = neighboarhood.edge(for: street.from) {
				fromEdge = foundFromEdge
				fromNeighbourhood = neighboarhood
			}
			if let foundToEdge = neighboarhood.edge(for: street.to) {
				toEdge = foundToEdge
				toNeighbourhood = neighboarhood
			}
		}

		guard let fromNeighbourhood = fromNeighbourhood else {
			assertionFailure("Map layout could not find starting neighbourhood for street \(street)")
			return nil
		}
		guard let fromEdge = fromEdge else {
			assertionFailure("Map layout could not find starting edge for street \(street)")
			return nil
		}
		guard let toNeighbourhood = toNeighbourhood else {
			assertionFailure("Map layout could not find ending neighbourhood for street \(street)")
			return nil
		}
		guard let toEdge = toEdge else {
			assertionFailure("Map layout could not find ending edge for street \(street)")
			return nil
		}
		guard fromEdge == toEdge.opposite else {
			assertionFailure("fromEdge in not opposite to toEdge in street \(street)")
			return nil
		}

		return .init(
			regionId: street.id,
			typeId: street.typeId,
			from: .init(regionType: fromNeighbourhood.typeId, edge: fromEdge, position: fromNeighbourhood.position),
			to: .init(regionType: toNeighbourhood.typeId, edge: toEdge, position: toNeighbourhood.position)
		)
	}
}
