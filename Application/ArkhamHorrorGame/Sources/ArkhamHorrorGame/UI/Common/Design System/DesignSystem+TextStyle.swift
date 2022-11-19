//
//  TextStyle.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Foundation
import Prelude
import SwiftUI
import ArkhamHorror

struct IconStyle {
    #if os(iOS)
    typealias Weight = UImage.SymbolWeight
    #elseif os(macOS)
    typealias Weight = UFont.Weight
    #endif

    var pointSize: UFloat
    var weight: Weight

    func smaller(by sizeDifference: UFloat) -> IconStyle {
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

    func toAttributes() -> AttributeContainer {
        var attributes = AttributeContainer()
        attributes.font = font
        attributes.foregroundColor = color
        return attributes
    }
}

extension DesignSystem {
    enum TextStyle {
        enum Menu {
            static let h1 = ArkhamHorrorGame.TextStyle(
                font: .Design.titleSC,
                iconStyle: .init(pointSize: 18, weight: .bold),
                color: .Design.Content.main
            )
            static let h2 = ArkhamHorrorGame.TextStyle(
                font: .Design.subtitleSC,
                iconStyle: .init(pointSize: 18, weight: .semibold),
                color: .Design.Content.main
            )
            static let h3 = ArkhamHorrorGame.TextStyle(
                font: .Design.subsubtitleSC,
                iconStyle: .init(pointSize: 16, weight: .semibold),
                color: .Design.Content.main
            )
            static let h4 = ArkhamHorrorGame.TextStyle(
                font: .Design.bodySC,
                iconStyle: .init(pointSize: 12, weight: .regular),
                color: .Design.Content.main
            )
            static let body = ArkhamHorrorGame.TextStyle(
                font: .Design.body,
                iconStyle: .init(pointSize: 12, weight: .regular),
                color: .Design.Content.main
            )
            static let keyword = ArkhamHorrorGame.TextStyle(
                font: .Design.keywordSC,
                iconStyle: .init(pointSize: 12, weight: .regular),
                color: .Design.Content.main
            )
            static let story = ArkhamHorrorGame.TextStyle(
                font: .Design.bodyItalic,
                iconStyle: .init(pointSize: 12, weight: .regular),
                color: .Design.Content.main
            )
            static let debug = ArkhamHorrorGame.TextStyle(
                font: .Design.debug,
                iconStyle: .init(pointSize: 12, weight: .regular),
                color: .Design.Content.main
            )
        }

        static let body = ArkhamHorrorGame.TextStyle(
            font: .Design.body,
            iconStyle: .init(pointSize: 12, weight: .regular),
            color: .Design.Content.secondary
        )
        static let keyword = ArkhamHorrorGame.TextStyle(
            font: .Design.keyword,
            iconStyle: .init(pointSize: 12, weight: .bold),
            color: .Design.Content.secondary
        )
        static let debug = ArkhamHorrorGame.TextStyle(
            font: .Design.debug,
            iconStyle: .init(pointSize: 12, weight: .light),
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

extension AttributedString {
    func styled(_ textStyle: TextStyle) -> AttributedString {
        self.mergingAttributes(textStyle.toAttributes())
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        let styles: [TextStyle] = [
            .Design.Menu.h1,
            .Design.Menu.h2,
            .Design.Menu.body,
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
