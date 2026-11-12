//
//  MapTile.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Prelude
import Common

public final class MapRegion: Identifiable {
	public let id: Region.ID
	public let name: Region.Name?
	public let typeId: RegionType.ID

	public init(
		id: Region.ID,
		name: Region.Name?,
		typeId: RegionType.ID
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
