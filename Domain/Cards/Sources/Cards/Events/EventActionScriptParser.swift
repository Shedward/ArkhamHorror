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

		try parser.register(DrawSpellParser())
		try parser.register(DrawSpecialParser())
		try parser.register(DrawAllyParser())

		try parser.register(GetRemnantParser())
		try parser.register(GetMoneyParser())

		try parser.register(TakeDamageParser())
		try parser.register(TakeHorrorParser())
		try parser.register(RestoreDamageParser())
		try parser.register(RestoreHorrorParser())

		try parser.register(BecomeBlessedParser())
		try parser.register(BecomeCursedParser())
		try parser.register(BecomeDelayedParser())

		return parser
	}
}
