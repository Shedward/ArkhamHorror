//
//  TextStyle.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import Foundation
import SwiftUI
import Prelude

public struct IconStyle {
    #if os(iOS)
    public typealias Weight = UImage.SymbolWeight
    #elseif os(macOS)
    public typealias Weight = UFont.Weight
    #endif

    public var pointSize: UFloat
    public var weight: Weight

    public func smaller(by sizeDifference: UFloat) -> IconStyle {
        with(self) {
            $0.pointSize -= sizeDifference
        }
    }
}

public struct TextStyle {
    public var font: UFont
    public var iconStyle: IconStyle
    public var color: UColor

    public init(font: UFont, iconStyle: IconStyle, color: UColor) {
        self.font = font
        self.iconStyle = iconStyle
        self.color = color
    }

    public func withColor(_ color: UColor) -> TextStyle {
        with(self) {
            $0.color = color
        }
    }

    public func withIconStyle(_ iconStyle: IconStyle) -> TextStyle {
        with(self) {
            $0.iconStyle = iconStyle
        }
    }

    public func toAttributes() -> AttributeContainer {
        var attributes = AttributeContainer()
        attributes.font = font
        attributes.foregroundColor = color
        return attributes
    }
}

extension DesignSystem {
    public typealias TextKind = KeyPath<TextTheme, TextStyle>

    public struct TextTheme {
        public struct Menu {
            public let h1: TextStyle
            public let h2: TextStyle
            public let h3: TextStyle
            public let h4: TextStyle
            public let body: TextStyle
            public let keyword: TextStyle
            public let story: TextStyle
            public let debug: TextStyle
        }

        public struct Content {
            public let body: TextStyle
            public let keyword: TextStyle
            public let debug: TextStyle
        }

        public struct Failure {
            public let title: TextStyle
            public let message: TextStyle
        }

        public let menu: Menu
        public let content: Content
        public let failure: Failure

        public func by(_ kind: TextKind) -> TextStyle {
            self[keyPath: kind]
        }

        public static func withColorTheme(_ color: ColorTheme) -> TextTheme {
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
                ),
                failure: .init(
                    title: .init(
                        font: .Design.debug,
                        iconStyle: .init(pointSize: 16, weight: .bold),
                        color: color.tint.bad
                    ),
                    message: .init(
                        font: .Design.debug,
                        iconStyle: .init(pointSize: 12, weight: .regular),
                        color: color.tint.bad
                    )
                )
            )
        }
    }
}

extension NSAttributedString {
    public convenience init(string: String, style: TextStyle) {
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
    public func styled(_ textStyle: TextStyle) -> NSAttributedString {
        .init(string: self, style: textStyle)
    }
}

extension Text {
    public func styled(_ textStyle: TextStyle) -> Text {
        foregroundColor(.init(textStyle.color.cgColor))
            .font(.init(textStyle.font))
    }
}

extension AttributedString {
    public func styled(_ textStyle: TextStyle) -> AttributedString {
        self.mergingAttributes(textStyle.toAttributes())
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    public static var previews: some View {

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
