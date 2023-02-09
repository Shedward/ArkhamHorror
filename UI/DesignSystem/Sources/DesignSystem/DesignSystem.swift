//
//  DesignSystem.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

public class DesignSystem {
    public let color: ColorTheme
    public let text: TextTheme

    public init(named name: String) {
        color = .named(name)
        text = .withColorTheme(color)
    }

    public static let `default` = DesignSystem(named: "monoDarkColors")
}
