//
//  TransitionProtocols.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

typealias TransitionAction<Node> = (Node, Node) async -> Void

protocol NodeTransition {
    associatedtype Node

    func enter(node: Node, in parent: Node) async
    func leave(node: Node, in parent: Node) async
}

struct AnyNodeTransition<Node>: NodeTransition {
    private let enterAction: TransitionAction<Node>
    private let leaveAction: TransitionAction<Node>

    init<Wrapped: NodeTransition>(_ wrapped: Wrapped) where Wrapped.Node == Node {
        self.enterAction = wrapped.enter
        self.leaveAction = wrapped.leave
    }

    func enter(node: Node, in parent: Node) async {
        await enterAction(node, parent)
    }

    func leave(node: Node, in parent: Node) async {
        await leaveAction(node, parent)
    }
}

extension NodeTransition {
    func asAny() -> AnyNodeTransition<Node> {
        AnyNodeTransition(self)
    }
}
