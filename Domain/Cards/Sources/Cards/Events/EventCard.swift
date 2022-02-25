//
//  EventCard.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

import Foundation
import Common
import Script
import FormattedText
import Yams

struct EventCardData: Decodable {
	let id: Event.Id
	let regionId: Region.Id
	let text: String
	let action: String
}

public struct EventCard {
	let id: Event.Id
	let regionId: Region.Id
	let text: FormattedText
	let action: Script<EventContext, Void>

	public init(
		data: Data,
		scriptParser: ScriptParser<EventContext, Void>,
		formattedTextParser: FormattedTextParser
	) throws {
		let decoder = YAMLDecoder()
		let eventData = try decoder.decode(EventCardData.self, from: data)
		try self.init(cardData: eventData, scriptParser: scriptParser, formattedTextParser: formattedTextParser)
	}

	init(
		cardData: EventCardData,
		scriptParser: ScriptParser<EventContext, Void>,
		formattedTextParser: FormattedTextParser
	) throws {
		id = cardData.id
		regionId = cardData.regionId
		text = try formattedTextParser.parse(cardData.text)
		action = try scriptParser.parse(string: cardData.action)
	}
}
