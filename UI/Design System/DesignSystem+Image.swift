//
//  DesignSystem+Image.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

extension Image {
    #if os(iOS)
    init?(systemName: String, withStyle textStyle: TextStyle) {
        let fontConfiguration = UImage.SymbolConfiguration(
            pointSize: CGFloat(textStyle.iconStyle.pointSize),
            weight: textStyle.iconStyle.weight
        )
        let colorConfiguration = UImage.SymbolConfiguration(hierarchicalColor: textStyle.color)
        let fullConfiguration = fontConfiguration.applying(colorConfiguration)
        guard let image = UImage(
            systemName: systemName,
            withConfiguration: fullConfiguration
        ) else {
            return nil
        }

        self.init(uiImage: image)
    }

    #elseif os(macOS)
    init?(systemName: String, withStyle textStyle: TextStyle) {
        let fontConfiguration = UImage.SymbolConfiguration(
            pointSize: textStyle.iconStyle.pointSize,
            weight: textStyle.iconStyle.weight
        )
        let colorConfiguration = UImage.SymbolConfiguration(hierarchicalColor: textStyle.color)
        let fullConfiguration = fontConfiguration.applying(colorConfiguration)
        guard let image = UImage(
            systemSymbolName: systemName,
            accessibilityDescription: nil
        )?.withSymbolConfiguration(fullConfiguration) else {
            return nil
        }

        self.init(nsImage: image)
    }
    #endif
}
