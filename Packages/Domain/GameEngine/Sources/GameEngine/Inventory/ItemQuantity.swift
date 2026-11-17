import Scripting

struct ItemQuantity: Parsable {
    static var one: Self {
        Self(expression: .constant(1))
    }

    let expression: AnyExpression<Int, EncounterContext>

    private init(expression: AnyExpression<Int, EncounterContext>) {
        self.expression = expression
    }

    init(argument: ParsableArgument<EncounterContext>) throws {
        if let count = try? argument.asInt(), count <= 0 {
            throw ScriptError("The 'count:' literal must be greater than zero")
        }
        expression = try argument.asAnyExpression(Int.self).validating { count in
            guard count >= 0 else { throw ScriptError("Item count cannot be negative") }
        }
    }
}
