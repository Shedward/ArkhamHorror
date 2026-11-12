//
//  MapNavigator.swift
//  
//
//  Created by Vladislav Maltsev on 03.03.2023.
//

import Common

public final class MapCoordinateSystem {
    private let mapLayout: MapLayout
    private let mapGeometry: MapGeometry

    private var regions: [Region.ID: MapGeometry.Region] = [:]

    public init(mapLayout: MapLayout, mapGeometry: MapGeometry) {
        self.mapLayout = mapLayout
        self.mapGeometry = mapGeometry
    }

    public func position(for regionId: Region.ID) -> Geometry.Point? {
        precalculateRegionsIfNeeded()
        guard let region = regions[regionId] else { return nil }
        return region.center
    }

    private func precalculateRegionsIfNeeded() {
        guard regions.isEmpty else { return }

        var regions: [Region.ID: MapGeometry.Region] = [:]

        mapLayout.neighboarhoods.forEach { neighboarhood in
            let hexagon = mapGeometry.hexagon(at: neighboarhood.position.toHexagonPosition())
            neighboarhood.regions.forEach { regionId in
                guard let edge = neighboarhood.edge(for: regionId) else { return }
                let region = hexagon.region(at: edge)
                regions[regionId] = region
            }
        }

        mapLayout.streets.forEach { street in
            let bridge = mapGeometry.bridge(
                from: street.from.position.toHexagonPosition(),
                to: street.to.position.toHexagonPosition(),
                fromEdge: street.from.edge
            )
            let region = bridge.region()
            regions[street.regionId] = region
        }

        self.regions = regions
    }
}
