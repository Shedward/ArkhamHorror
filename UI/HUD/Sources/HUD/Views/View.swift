//
//  View.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit
import Prelude

open class View {
    public var node: SKNode
    public private(set) weak var superview: View?
    public private(set) var childs: [View]

    public init(node: SKNode = .init()) {
        self.node = node
        self.childs = []
    }

    public func addChild(_ child: View) {
        child.superview = self
        childs.append(child)
        node.addChild(child.node)
    }

    public func removeFromSuperview() {
        guard let superview else { return }
        superview.childs = superview.childs.filter { $0 !== self }
        superview.node.removeFromParent()
    }

    public func removeAllChilds() {
        childs = []
        node.removeAllChildren()
    }

    public func layout() {
        childs.forEach { $0.layout() }
        layoutSubviews()
    }

    public func layoutSubviews() {
    }
}
