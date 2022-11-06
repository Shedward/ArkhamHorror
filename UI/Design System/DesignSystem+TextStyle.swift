//
//  TextStyle.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Foundation
import Prelude
import SwiftUI

struct IconStyle {
    var pointSize: UFloat
    var weight: UFont.Weight

    func smaller(by sizeDifference: CGFloat) -> IconStyle {
        with(self) {
            $0.pointSize -= sizeDifference
        }
    }
}

struct TextStyle {
    var font: UFont
    var iconStyle: IconStyle
    var color: UColor

    init(font: UFont, iconStyle: IconStyle, color: UColor) {
        self.font = font
        self.iconStyle = iconStyle
        self.color = color
    }

    func withColor(_ color: UColor) -> TextStyle {
        with(self) {
            $0.color = color
        }
    }

    func withIconStyle(_ iconStyle: IconStyle) -> TextStyle {
        with(self) {
            $0.iconStyle = iconStyle
        }
    }
}

extension DesignSystem {
    enum TextStyle {
        static let menuTitle = Arkham_Horror.TextStyle(
            font: .Design.title,
            iconStyle: .init(pointSize: 18, weight: .bold),
            color: .Design.Content.main
        )
        static let menuSubtitle = Arkham_Horror.TextStyle(
            font: .Design.subtitle,
            iconStyle: .init(pointSize: 18, weight: .semibold),
            color: .Design.Content.main
        )
        static let menuBody = Arkham_Horror.TextStyle(
            font: .Design.body,
            iconStyle: .init(pointSize: 12, weight: .regular),
            color: .Design.Content.main
        )
        static let body = Arkham_Horror.TextStyle(
            font: .Design.body,
            iconStyle: .init(pointSize: 12, weight: .regular),
            color: .Design.Content.secondary
        )
        static let keyword = Arkham_Horror.TextStyle(
            font: .Design.keyword,
            iconStyle: .init(pointSize: 12, weight: .bold),
            color: .Design.Content.secondary
        )
        static let debug = Arkham_Horror.TextStyle(
            font: .Design.debug,
            iconStyle: .init(pointSize: 12, weight: .regular),
            color: .Design.Content.secondary
        )
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

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        let styles: [TextStyle] = [
            .Design.menuTitle,
            .Design.menuSubtitle,
            .Design.menuBody,
            .Design.body,
            .Design.debug,
            .Design.keyword
        ]

        VStack {
            ForEach(styles.indices, id: \.self) { index in
                let style = styles[index]
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "function", withStyle: style)
                    Text(verbatim: "f(x) \(style.font.fontName)")
                        .styled(style)
                    Image(systemName: "car", withStyle: style)
                }
                .background(.blue)
            }
        }
    }
}
