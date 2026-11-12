//
//  MapData.swift
//  
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

struct MapData: Decodable {
	let sityNeighborhoods: MapNeighborhoodsData
	let sityStreets: MapStreetsData
	let layout: MapNeighborhoodsLayoutData
}
