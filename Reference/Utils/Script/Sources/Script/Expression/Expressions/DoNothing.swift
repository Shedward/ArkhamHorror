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

public struct DoNothingParser<Context>: ExpressionParser {
	public let head = "doNothing"
	public let doc = ExpressionDoc(
		signature: "(doNothing):Void",
		description: "Do nothing."
	)

	public init() {
	}

	public func parse(_ reader: ExpressionParameterReader<Context>) throws -> AnyExpression<Context, Void> {
		DoNothing().asAny()
	}
}
