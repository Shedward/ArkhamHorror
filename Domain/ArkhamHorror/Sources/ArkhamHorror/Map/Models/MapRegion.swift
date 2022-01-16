//
//  MapTile.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

public final class MapRegion {
	public enum IdTag {}
	public typealias Id = Tagged<IdTag, String>
	public enum NameTag {}
	public typealias Name = Tagged<NameTag, String>

	public let id: Id
	public let name: Name?
	public let typeId: MapRegionType.Id

	public init(
		id: Id,
		name: Name?,
		typeId: MapRegionType.Id
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
