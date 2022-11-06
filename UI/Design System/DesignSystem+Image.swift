//
//  DesignSystem+Image.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

extension Image {
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
}
