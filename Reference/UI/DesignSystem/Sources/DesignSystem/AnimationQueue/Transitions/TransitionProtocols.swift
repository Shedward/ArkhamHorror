//
//  TransitionProtocols.swift
//  
//
//  Created by Vladislav Maltsev on 18.02.2023.
//

public typealias TransitionAction<Node> = (Node, Node) -> Void

public protocol NodeTransition {
    associatedtype Node

    func enter(node: Node, in parent: Node)
    func leave(node: Node, in parent: Node)
}

public struct AnyNodeTransition<Node>: NodeTransition {
    private let enterAction: TransitionAction<Node>
    private let leaveAction: TransitionAction<Node>

    public init<Wrapped: NodeTransition>(_ wrapped: Wrapped) where Wrapped.Node == Node {
        self.enterAction = wrapped.enter
        self.leaveAction = wrapped.leave
    }

    public func enter(node: Node, in parent: Node) {
        enterAction(node, parent)
    }

    public func leave(node: Node, in parent: Node) {
        leaveAction(node, parent)
    }
}

extension NodeTransition {
    public func asAny() -> AnyNodeTransition<Node> {
        AnyNodeTransition(self)
    }
}
