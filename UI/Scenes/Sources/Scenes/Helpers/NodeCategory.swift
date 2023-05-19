//
//  NodeCategory.swift
//  
//
//  Created by Vladislav Maltsev on 17.05.2023.
//

import Foundation
import SceneKit

public struct NodeCategory: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let `default`                = NodeCategory(rawValue: 1 << 0);
    public static let userInteractionEnabled   = NodeCategory(rawValue: 1 << 1);

    public func asNSNumber() -> NSNumber {
        rawValue as NSNumber
    }
}

public extension SCNNode {
    var category: NodeCategory {
        get {
            NodeCategory(rawValue: self.categoryBitMask)
        }
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}
