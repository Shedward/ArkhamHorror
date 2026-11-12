//
//  Shader.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

protocol Shader {
    associatedtype Attributes: RawRepresentable where Attributes.RawValue == String
    static var shader: SKShader { get }
}

struct AttachedShader<S: Shader> {
    private weak var node: SKAttributableNode?

    init(node: SKAttributableNode, shader: S.Type) {
        self.node = node
    }

    func setValue<T: SKAttributable>(
        _ value: T,
        forAttribute attribute: S.Attributes
    ) {
        node?.setValue(value, forAttribute: attribute)
    }
}

extension SKAttributableNode {
    func attachShader<S: Shader>(_ type: S.Type) -> AttachedShader<S> {
        self.shader = S.shader
        return AttachedShader(node: self, shader: S.self)
    }
}

extension SKShapeNode {
    func attachStrokeShader<S: Shader>(_ type: S.Type) -> AttachedShader<S> {
        self.strokeShader = S.shader
        return AttachedShader(node: self, shader: S.self)
    }
}
