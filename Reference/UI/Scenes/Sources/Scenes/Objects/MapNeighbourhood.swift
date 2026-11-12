//
//  MapNeighbourhood.swift
//  
//
//  Created by Vladislav Maltsev on 17.02.2023.
//

import SceneKit
import Common
import Map

public final class MapNegihbourhood: SceneObject {
    public let regionTypeId: RegionType.ID
    public let regions: [MapRegion]

    public init(
        regionTypeId: RegionType.ID,
        hexagon: MapGeometry.Hexagon,
        regions: [MapRegion]
    ) {
        self.regionTypeId = regionTypeId
        self.regions = regions
        super.init()
        regions.forEach { addChild($0) }
        node.simdPosition = hexagon.origin.toVec3()
    }
}
