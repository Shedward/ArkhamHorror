//
//  HealTargetParser.swift
//  
//
//  Created by Vladislav Maltsev on 12.03.2022.
//

import Script

struct HealTargetParser: DataParser {
	func parse(
		head: String,
		parametersReader: ExpressionParameterReader<EventContext>
	) throws -> Set<HealthChangeRequest.Target> {
		guard head == "healTarget" else {
			throw DataError(message: "Expected healTarget")
		}

		var targets: Set<HealthChangeRequest.Target> = []

		while parametersReader.haveAnotherParameter() {
			targets.insert(try parametersReader.readRaw(HealthChangeRequest.Target.self))
		}

		if targets.isEmpty {
			throw ParameterError(message: "Heal targets should not be empty")
		}

		return targets
	}
}
