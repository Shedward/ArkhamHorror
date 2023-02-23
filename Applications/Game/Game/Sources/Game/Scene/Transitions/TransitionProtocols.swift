//
//  TransitionProtocols.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

typealias TransitionAction<Node> = (Node, Node) -> Void

protocol NodeTransition {
    associatedtype Node

    func enter(node: Node, in parent: Node)
    func leave(node: Node, in parent: Node)
}

struct AnyNodeTransition<Node>: NodeTransition {
    private let enterAction: TransitionAction<Node>
    private let leaveAction: TransitionAction<Node>

    init<Wrapped: NodeTransition>(_ wrapped: Wrapped) where Wrapped.Node == Node {
        self.enterAction = wrapped.enter
        self.leaveAction = wrapped.leave
    }

    func enter(node: Node, in parent: Node) {
        enterAction(node, parent)
    }

    func leave(node: Node, in parent: Node) {
        leaveAction(node, parent)
    }
}

extension NodeTransition {
    func asAny() -> AnyNodeTransition<Node> {
        AnyNodeTransition(self)
    }
}
