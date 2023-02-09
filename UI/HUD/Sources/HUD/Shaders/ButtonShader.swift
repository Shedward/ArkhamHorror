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
                float4 color = texture2D(u_texture, v_tex_coord);

                // border
                float4 borderHighlight = (
                    v_tex_coord.x < uvBorderWidth.x || v_tex_coord.y < uvBorderWidth.y
                    || v_tex_coord.x > (1 - uvBorderWidth.x) || v_tex_coord.y > (1 - uvBorderWidth.y)
                )
                    ? float4(1.0, 1.0, 1.0, 0.85)
                    : float4(1.0, 1.0, 1.0, 1.0);

                float4 addition = u_isSelected
                    ? float4(0.3, 0.3, 0.3, 0.0)
                    : float4(0.0, 0.0, 0.0, 0.0);

                gl_FragColor = borderHighlight * color + addition;
            }
            """
        )

        shader.attributes = [
            .init(named: Attributes.size, type: Size.self),
            .init(named: Attributes.borderWidth, type: Length.self),
            .init(named: Attributes.isSelected, type: Bool.self)
        ]

        return shader
    }()
}
