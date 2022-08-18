//
//  TextStyle.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Foundation
import SwiftUI

struct TextStyle {
    var font: UFont
    var color: UColor

    init(font: UFont, color: UColor) {
        self.font = font
        self.color = color
    }

    func withColor(_ color: UColor) -> TextStyle {
        var newStyle = self
        newStyle.color = color
        return newStyle
    }
}

extension DesignSystem {
    enum TextStyle {
        static let title = Arkham_Horror.TextStyle(font: .Design.title, color: .Design.Content.main)
        static let subtitle = Arkham_Horror.TextStyle(font: .Design.subtitle, color: .Design.Content.main)
        static let body = Arkham_Horror.TextStyle(font: .Design.body, color: .Design.Content.secondary)
        static let keyword = Arkham_Horror.TextStyle(font: .Design.keyword, color: .Design.Content.secondary)
        static let debug = Arkham_Horror.TextStyle(font: .Design.debug, color: .Design.Content.secondary)
    }
}

extension TextStyle {
    typealias Design = DesignSystem.TextStyle
}

extension NSAttributedString {
    convenience init(string: String, style: TextStyle) {
        self.init(
            string: string,
            attributes: [
                .font: style.font,
                .foregroundColor: style.color
            ]
        )
    }
}

extension String {
    func styled(_ textStyle: TextStyle) -> NSAttributedString {
        .init(string: self, style: textStyle)
    }
}

extension Text {
    func styled(_ textStyle: TextStyle) -> Text {
        foregroundColor(.init(textStyle.color.cgColor))
            .font(.init(textStyle.font))
    }
}
