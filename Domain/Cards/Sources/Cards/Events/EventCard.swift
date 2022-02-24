//
//  EventCard.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

import Common
import Script
import FormattedText

public struct EventCardData: Decodable {
	let id: Event.Id
	let regionId: Region.Id
	let text: String
	let action: String
}

public struct EventCard {
	let id: Event.Id
	let regionId: Region.Id
	let text: String
	let action: String

	init(
		data: EventCardData,
		scriptParser: ScriptParser,
		formattedTextParser: FormattedTextParser
	) throws {
		id = data.id
		regionId = data.regionId
		text = try formattedTextParser.parse(data.text)
		action = try scriptParser.parse(string: action)
	}
}
