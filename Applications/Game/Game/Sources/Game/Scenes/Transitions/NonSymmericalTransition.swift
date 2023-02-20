//
//  NonSymmericalTransition.swift
//  
//
//  Created by Vladislav Maltsev on 19.02.2023.
//

struct NonSymmericalTransition<Node>: NodeTransition {
    private let enterAction: TransitionAction<Node>
    private let leaveAction: TransitionAction<Node>

    init<EnterTransition: NodeTransition, LeaveTransition: NodeTransition>(
        enter: EnterTransition,
        leave: LeaveTransition
    ) where EnterTransition.Node == LeaveTransition.Node, EnterTransition.Node == Node {
        enterAction = enter.enter
        leaveAction = leave.leave
    }

    func enter(node: Node, in parent: Node) async {
        await enterAction(node, parent)
    }

    func leave(node: Node, in parent: Node) async {
        await leaveAction(node, parent)
    }
}
