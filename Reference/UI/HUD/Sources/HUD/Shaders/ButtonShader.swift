//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 05.02.2023.
//

import SpriteKit

struct ButtonShader: Shader {
    enum Attributes: String {
        case size = "u_size"
        case borderWidth = "u_borderWidth"
        case isSelected = "u_isSelected"
    }

    static var shader: SKShader = {
        let shader = SKShader(source:
            """
            void main() {
                float2 uvBorderWidth = u_borderWidth / u_size;
                float4 color = SKDefaultShading();

                // border
                float4 borderHighlight = (
                    v_tex_coord.x < uvBorderWidth.x || v_tex_coord.y < uvBorderWidth.y
                    || v_tex_coord.x > (1 - uvBorderWidth.x) || v_tex_coord.y > (1 - uvBorderWidth.y)
                )
                    ? float4(2.0, 2.0, 2.0, 1.0)
                    : float4(1.0, 1.0, 1.0, 1.0);

                // selection highlight
                float4 highlight = u_isSelected
                    ? float4(0.5, 0.5, 0.5, 1.0)
                    : float4(1.0, 1.0, 1.0, 1.0);

                gl_FragColor = color * borderHighlight * highlight;
            }
            """
        )

        shader.attributes = [
            .init(named: Attributes.size, type: CGSize.self),
            .init(named: Attributes.borderWidth, type: CGFloat.self),
            .init(named: Attributes.isSelected, type: Bool.self)
        ]

        return shader
    }()
}
