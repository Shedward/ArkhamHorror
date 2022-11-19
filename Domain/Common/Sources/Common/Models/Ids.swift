//
//  Ids.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Prelude

public enum Region {
	public enum IdTag {}
	public typealias ID = Tagged<IdTag, String>

	public enum NameTag {}
	public typealias Name = Tagged<NameTag, String>
}

public enum RegionType {
	public enum IdTag {}
	public typealias ID = Tagged<IdTag, String>

	public enum NameTag {}
	public typealias Name = Tagged<NameTag, String>
}

public enum Event {
	public enum IdTag {}
	public typealias ID = Tagged<IdTag, String>
}
