//
//  EventCard.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

struct EventCardData: Decodable {
	let id: String
	let regionId: String
	let text: String
	let action: String
}

public struct EventCard {
	init(data: EventCardData) {
	}
}
