//
//  Do.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct Do<Context>: Expression {
	private let actions: [AnyAction<Context>]

	public init(_ actions: AnyAction<Context>...) {
		self.actions = actions
	}

	public init(actions: [AnyAction<Context>]) {
		self.actions = actions
	}

	public func resolve(in context: Context) async {
		for action in actions {
			await action.resolve(in: context)
		}
	}
}

public struct DoParser<Context>: ExpressionParser {
	public let head = "do"
	public let doc = ExpressionDoc(
		signature: "(do (action1):Void (action2):Void ...):Void",
		description: """
		Do all actions in order. If no actions provided - do nothing.
		""",
		example: "(do (heal 3) (getMoney 3))"
	)

	public init() {
	}

	public func parse(_ reader: ExpressionParameterReader<Context>) throws -> AnyExpression<Context, Void> {
		var actions: [AnyAction<Context>] = []
		while reader.haveParameter() {
			actions.append(try reader.readExpression())
		}
		return Do(actions: actions).asAny()
	}
}
