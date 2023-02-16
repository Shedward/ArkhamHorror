//
//  SceneObject.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SceneKit

open class SceneObject {
    public var node: SCNNode
    public private(set) var parrent: SceneObject?
    public private(set) var childs: [SceneObject] = []

    public init(node: SCNNode = SCNNode()) {
        self.node = node
    }

    public func addChild(_ child: SceneObject) {
        child.parrent = self
        node.addChildNode(child.node)
        childs.append(child)
    }

    public func removeFromParrent() {
        guard let parrent else { return }
        parrent.childs = parrent.childs.filter { $0 !== self }
        parrent.node.removeFromParentNode()
    }
}
