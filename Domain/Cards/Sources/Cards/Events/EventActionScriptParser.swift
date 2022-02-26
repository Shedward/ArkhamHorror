//
//  EventActionScriptParser.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Script

enum EventActionScriptParser {
	static func create() throws -> ScriptParser<EventContext, Void> {
		var parser = ScriptParser<EventContext, Void>()

		try parser.register(DoParser())
		try parser.register(IfParser<EventContext, Void>())
		try parser.register(IfParser<EventContext, Bool>())
		try parser.register(DoNothingParser())

		try parser.register(AskParser())
		try parser.register(ChooseOneParser<Void>())
		try parser.register(ChooseOneParser<Bool>())

		try parser.register(TestSkillParser())
		try parser.register(SpendMoneyParser())
		try parser.register(SpendRemnantParser())
		try parser.register(SpendClueParser())

		return parser
	}
}
