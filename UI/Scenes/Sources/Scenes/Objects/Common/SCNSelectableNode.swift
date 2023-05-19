//
//  SCNSelectableNode.swift
//  
//
//  Created by Vladislav Maltsev on 17.05.2023.
//

import SceneKit

open class SCNSelectableNode: SCNNode {
    public var onTap: (() -> Void)?

    public var isUserInteractionEnabled: Bool = false {
        didSet {
            if isUserInteractionEnabled {
                category.insert(.userInteractionEnabled)
            } else {
                category.remove(.userInteractionEnabled)
            }
        }
    }

    public func didTap() {
        onTap?()
    }
}
