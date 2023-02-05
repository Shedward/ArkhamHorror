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
