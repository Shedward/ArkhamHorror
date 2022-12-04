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
    typealias TextKind = KeyPath<TextTheme, TextStyle>

    struct TextTheme {
        struct Menu {
            let h1: TextStyle
            let h2: TextStyle
            let h3: TextStyle
            let h4: TextStyle
            let body: TextStyle
            let keyword: TextStyle
            let story: TextStyle
            let debug: TextStyle
        }

        struct Content {
            let body: TextStyle
            let keyword: TextStyle
            let debug: TextStyle
        }

        let menu: Menu
        let content: Content

        func by(_ kind: TextKind) -> TextStyle {
            self[keyPath: kind]
        }

        static func withColorTheme(_ color: ColorTheme) -> TextTheme {
            .init(
                menu: .init(
                    h1: .init(
                        font: .Design.titleSC,
                        iconStyle: .init(pointSize: 18, weight: .bold),
                        color: color.content.main
                    ),
                    h2: .init(
                        font: .Design.subtitleSC,
                        iconStyle: .init(pointSize: 18, weight: .semibold),
                        color: color.content.main
                    ),
                    h3: .init(
                        font: .Design.subsubtitleSC,
                        iconStyle: .init(pointSize: 16, weight: .semibold),
                        color: color.content.main
                    ),
                    h4: .init(
                        font: .Design.bodySC,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.content.main
                    ),
                    body: .init(
                        font: .Design.body,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.content.main
                    ),
                    keyword: .init(
                        font: .Design.keywordSC,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.content.main
                    ),
                    story: .init(
                        font: .Design.bodyItalic,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.content.main
                    ),
                    debug: .init(
                        font: .Design.debug,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.content.main
                    )
                ),
                content: .init(
                    body: .init(
                        font: .Design.body,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.content.secondary
                    ),
                    keyword: .init(
                        font: .Design.keyword,
                        iconStyle: .init(pointSize: 12, weight: .bold),
                        color: color.content.secondary
                    ),
                    debug: .init(
                        font: .Design.debug,
                        iconStyle: .init(pointSize: 12, weight: .light),
                        color: color.content.secondary
                    )
                )
            )
        }
    }
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

        let design = DesignSystem.default
        let styles: [TextStyle] = [
            design.text.menu.h1,
            design.text.menu.h2,
            design.text.menu.h3,
            design.text.menu.h4,
            design.text.menu.body,
            design.text.menu.story,
            design.text.menu.keyword,
            design.text.menu.debug,
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
