//
//  NonSymmericalTransition.swift
//  
//
//  Created by Vladislav Maltsev on 19.02.2023.
//

public struct NonSymmericalTransition<Node>: NodeTransition {
    private let enterAction: TransitionAction<Node>
    private let leaveAction: TransitionAction<Node>

    public init<EnterTransition: NodeTransition, LeaveTransition: NodeTransition>(
        enter: EnterTransition,
        leave: LeaveTransition
    ) where EnterTransition.Node == LeaveTransition.Node, EnterTransition.Node == Node {
        enterAction = enter.enter
        leaveAction = leave.leave
    }

    public func enter(node: Node, in parent: Node) {
        enterAction(node, parent)
    }

    public func leave(node: Node, in parent: Node) {
        leaveAction(node, parent)
    }
}
