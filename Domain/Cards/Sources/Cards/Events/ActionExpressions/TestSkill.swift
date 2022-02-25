//
//  TestSkill.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

import Script

struct TestSkill: Expression {
	let skill: Skill
	let minSuccessCount: Int

	func resolve(in context: EventContext) async -> Bool {
		let successCount = await context.testSkill(skill)
		return successCount >= minSuccessCount
	}
}

struct TestSkillParser: ExpressionParser {
	let head = "testSkill"
	let doc = ExpressionDoc(
		signature: #"(testSkill skill:Skill minSuccessCount:Int?):Bool"#,
		description: """
		Returns true if users pass skill test with success count > minSuccessCount,
		if minSuccessCount not provided, it counts as 1.
		""",
		example: #"(testSkill lore)"#
	)

	func parse(_ reader: ExpressionParameterReader<EventContext>) throws -> AnyExpression<EventContext, Bool> {
		let skill = try reader.readRaw(Skill.self)
		let count = (try? reader.readInt()) ?? 1
		return TestSkill(skill: skill, minSuccessCount: count).asAny()
	}
}
