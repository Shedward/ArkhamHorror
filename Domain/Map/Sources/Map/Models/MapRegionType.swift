//
//  MapRegionType.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Prelude
import Common

public struct MapRegionType: Identifiable {
	public let id: RegionType.ID
	public let name: RegionType.Name
}

extension MapRegionType: Equatable {
	public static func == (_ lhs: MapRegionType, _ rhs: MapRegionType) -> Bool {
		lhs.id == rhs.id
	}
}
