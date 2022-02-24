//
//  MapTile.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Prelude
import Common

public final class MapRegion {
	public let id: Region.Id
	public let name: Region.Name?
	public let typeId: RegionType.Id

	public init(
		id: Region.Id,
		name: Region.Name?,
		typeId: RegionType.Id
	) {
		self.id = id
		self.name = name
		self.typeId = typeId
	}
}

extension MapRegion: Equatable {
	public static func == (_ lhs: MapRegion, _ rhs: MapRegion) -> Bool {
		lhs.id == rhs.id
	}
}
