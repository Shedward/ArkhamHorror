//
//  AnimationQueueAction.swift
//  
//
//  Created by Vladislav Maltsev on 04.03.2023.
//

import SpriteKit
import SceneKit

protocol AnimationQueueAction {
    var id: String { get }
    var duration: TimeInterval { get set }
    var speed: CGFloat { get set }

    @MainActor
    func run() async
}

extension SKNode {
    struct Action: AnimationQueueAction {
        let id: String
        weak var node: SKNode?
        var action: SKAction

        init(id: String, node: SKNode, action: SKAction) {
            self.id = id
            self.node = node
            self.action = action
        }

        var duration: TimeInterval {
            get { action.duration }
            set { action.duration = newValue }
        }

        var speed: CGFloat {
            get { action.speed }
            set { action.duration = newValue }
        }

        func run() async {
            await node?.run(action)
        }
    }

    public func enqueueAction(name: String, action: SKAction) {
        let id = name + "-" + UUID().uuidString
        let animationAction = Action(id: id, node: self, action: action)
        if let context = AnimationTransaction.current {
            context.enqueueAction(animationAction)
        } else {
            Task { await animationAction.run() }
        }
    }
}

extension SCNNode {
    struct Action: AnimationQueueAction {
        let id: String
        weak var node: SCNNode?
        var action: SCNAction

        init(id: String, node: SCNNode?, action: SCNAction) {
            self.id = id
            self.node = node
            self.action = action
        }

        var duration: TimeInterval {
            get { action.duration }
            set { action.duration = newValue }
        }

        var speed: CGFloat {
            get { action.speed }
            set { action.speed = newValue }
        }

        func run() async {
            await node?.runAction(action)
        }
    }

    public func enqueueAction(name: String, action: SCNAction) {
        let id = name + "-" + UUID().uuidString
        let animationAction = Action(id: id, node: self, action: action)
        if let context = AnimationTransaction.current {
            context.enqueueAction(animationAction)
        } else {
            Task { await animationAction.run() }
        }
    }
}
