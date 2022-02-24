//
//  MapRegionType.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Prelude
import Common

public struct MapRegionType {
	public let id: RegionType.Id
	public let name: RegionType.Name
}

extension MapRegionType: Equatable {
	public static func == (_ lhs: MapRegionType, _ rhs: MapRegionType) -> Bool {
		lhs.id == rhs.id
	}
}
