//
//  DesignSystem.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

class DesignSystem {
    let color: ColorTheme
    let text: TextTheme

    init(named name: String) {
        color = .named(name)
        text = .withColorTheme(color)
    }

    static let `default` = DesignSystem(named: "monoDarkColors")
}
