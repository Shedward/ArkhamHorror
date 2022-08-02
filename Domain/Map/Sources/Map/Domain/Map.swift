//
//  Map.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Foundation
import Graph
import Common
import Yams

public final class Map {
	private var neighborhoods: [MapRegionType] = []
	private var streetTypes: [MapRegionType] = []
	private var regions: [MapRegion] = []
	private var streets: [MapRegion] = []
	private var regionsGraph: Graph<Region.Id> = Graph()

	public let layout: MapLayout

	public convenience init(data: Data) throws {
		let decoder = YAMLDecoder()
		let mapData = try decoder.decode(MapData.self, from: data)
		self.init(mapData: mapData)
	}

	init(mapData: MapData) {
		layout = MapLayout(mapData: mapData)

		mapData.sityNeighborhoods.types.forEach { type  in
			neighborhoods.append(.init(id: type.id, name: type.name))
		}
		mapData.sityNeighborhoods.neighborhoods.forEach { neighborhood in
			neighborhood.regions.forEach { region in
				regions.append(.init(id: region.id, name: region.name, typeId: neighborhood.typeId))
			}
			let regionIds = neighborhood.regions.map { $0.id }
			GraphBuilder(graph: regionsGraph).createBidirectionalRing(regionIds)
		}
		mapData.sityStreets.types.forEach { streetType in
			streetTypes.append(.init(id: streetType.id, name: streetType.name))
		}
		mapData.sityStreets.streets.forEach { street in
			let streetRegion = MapRegion(id: street.id, name: nil, typeId: street.typeId)
			GraphBuilder(graph: regionsGraph).createBidirectionalBridge(streetRegion.id, from: street.from, to: street.to)
		}
	}

	public func region(by id: Region.Id) -> MapRegion? {
		regions.first { $0.id == id }
	}

	public func neighbourhood(by id: RegionType.Id) -> MapRegionType? {
		neighborhoods.first { $0.id == id }
	}

	public func isNeighborRegions(_ lhs: Region.Id, _ rhs: Region.Id) -> Bool {
		guard let lhsNode = regionsGraph.node(for: lhs) else { return false }
		guard let rhsNode = regionsGraph.node(for: rhs) else { return false }
		return lhsNode.isNeighbor(to: rhsNode)
	}

    public func neighbors(for id: Region.Id) -> [Region.Id] {
        let node = regionsGraph.node(for: id)
        return node?.neighbors.map { $0.value } ?? []
    }
}

extension Map {
    public func geometryRegion(by id: Region.Id, geometry: MapGeometry) -> MapGeometry.Region? {
        for neighboarhood in layout.neighboarhoods {
            if let neighboarhoodEdge = neighboarhood.edge(for: id) {
                let region = geometry.hexagon(at: neighboarhood.position.toHexagonPosition())
                    .region(at: neighboarhoodEdge)
                return region
            }
        }

        for street in layout.streets {
            if street.regionId == id {
                let bridge = geometry.bridge(
                    from: street.from.position.toHexagonPosition(),
                    to: street.to.position.toHexagonPosition(),
                    fromEdge: street.from.edge
                )

                return bridge.region()
            }
        }

        return nil
    }
}

extension Map {
    public func regionsMapDescription() -> String {
        DebugGraphFormatter().format(from: regionsGraph)
    }
}
