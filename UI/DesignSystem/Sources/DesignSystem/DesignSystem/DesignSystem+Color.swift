//
//  DesignSystem+Color.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import SwiftUI

extension DesignSystem {
    public typealias ColorKind = KeyPath<ColorTheme, UColor>

    public struct ColorTheme {
        public struct Background {
            public let main: UColor
            public let secondary: UColor
            public let tertiary: UColor
            public let quaternary: UColor
        }

        public struct Content {
            public let main: UColor
            public let secondary: UColor
        }

        public struct Fixed {
            public let black: UColor
        }

        public struct Tint {
            public let bad: UColor
            public let good: UColor
        }

        public let background: Background
        public let content: Content
        public let fixed: Fixed
        public let tint: Tint

        public func by(_ kind: ColorKind) -> UColor {
            self[keyPath: kind]
        }

        static func named(_ prefix: String) -> ColorTheme {
            func color(named name: String) -> UColor {
                DesignSystem.colorNamed("\(prefix).\(name)")
            }

            return .init(
                background: .init(
                    main: color(named: "background.main"),
                    secondary: color(named: "background.secondary"),
                    tertiary: color(named: "background.tertiary"),
                    quaternary: color(named: "background.quaternary")
                ),
                content: .init(
                    main: color(named: "content.main"),
                    secondary: color(named: "content.secondary")
                ),
                fixed: .init(
                    black: color(named: "fixed.black")
                ),
                tint: .init(
                    bad: color(named: "tint.bad"),
                    good: color(named: "tint.good")
                )
            )
        }
    }

    private static func colorNamed(_ name: String) -> UColor {
        #if os(iOS)
        UColor(named: name, in: .module, compatibleWith: nil)!
        #elseif os(macOS)
        UColor(named: name, bundle: .module)!
        #endif
    }
}

extension UColor {
    public var asColor: Color {
        Color(self)
    }
}

extension Color {
    public init(_ color: UColor) {
#if os(iOS)
        self = .init(uiColor: color)
#elseif os(macOS)
        self = .init(nsColor: color)
#endif
    }
}

extension View {
    public func foregroundColor(_ color: UColor) -> some View {
        foregroundColor(Color(color))
    }

    public func border(_ color: UColor) -> some View {
        border(Color(color))
    }
}
