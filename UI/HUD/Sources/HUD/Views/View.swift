//
//  View.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

open class View {
    public var node: SKNode
    public private(set) var superview: View?
    public private(set) var childs: [View]
    private var needLayoutSubviews: Bool = true

    public init(node: SKNode = .init()) {
        self.node = node
        self.childs = []
        setNeedsLayout()
    }

    public func addChild(_ child: View) {
        child.superview = self
        childs.append(child)
        node.addChild(child.node)
        setNeedsLayout()
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

    public func setNeedsLayout() {
        needLayoutSubviews = true
        superview?.setNeedsLayout()
    }

    public func layoutIfNeeded() {
        if needLayoutSubviews {
            needLayoutSubviews = false
            childs.forEach { $0.layoutIfNeeded() }
            layoutSubviews()
        }
    }

    public func layoutSubviews() {
    }
}
