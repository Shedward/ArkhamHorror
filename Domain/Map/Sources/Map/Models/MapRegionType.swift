//
//  MapRegionType.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import Prelude

public struct MapRegionType {
	public enum IdTag { }
	public typealias Id = Tagged<IdTag, String>

	public enum NameTag { }
	public typealias Name = Tagged<NameTag, String>

	public let id: Id
	public let name: Name
}

extension MapRegionType: Equatable {
	public static func == (_ lhs: MapRegionType, _ rhs: MapRegionType) -> Bool {
		lhs.id == rhs.id
	}
}
