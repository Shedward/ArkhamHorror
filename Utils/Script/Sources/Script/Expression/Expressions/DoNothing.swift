//
//  DoNothing.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct DoNothing<Context>: Expression {
	public init() {
	}

	public func resolve(in context: Context) async {
	}
}

public struct DoNothingParser<Context>: SParser {
	public let head = "doNothing"
	public let doc = SParserDoc(
		signature: "(doNothing):Void",
		description: "Do nothing."
	)

	public func parse(_ reader: SReader<Context>) throws -> AnyExpression<Context, Void> {
		DoNothing().asAny()
	}
}
