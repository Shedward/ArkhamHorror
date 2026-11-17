import Scripting

struct ChoiceAnswer<Output: Sendable>: Sendable {
    let choice: EncounterChoice
    let body: AnyExpression<Output, EncounterContext>
}
