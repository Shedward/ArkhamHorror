//
//  DesignSystem+Color.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import SwiftUI

extension DesignSystem {
    typealias ColorKind = KeyPath<ColorTheme, UColor>

    struct ColorTheme {
        struct Background {
            let main: UColor
            let secondary: UColor
            let tertiary: UColor
            let quaternary: UColor
        }

        struct Content {
            let main: UColor
            let secondary: UColor
        }

        struct Fixed {
            let black: UColor
        }

        struct Tint {
            let bad: UColor
            let good: UColor
        }

        let background: Background
        let content: Content
        let fixed: Fixed
        let tint: Tint

        func by(_ kind: ColorKind) -> UColor {
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
    var asColor: Color {
        Color(self)
    }
}

extension Color {
    init(_ color: UColor) {
#if os(iOS)
        self = .init(uiColor: color)
#elseif os(macOS)
        self = .init(nsColor: color)
#endif
    }
}

extension View {
    func foregroundColor(_ color: UColor) -> some View {
        foregroundColor(Color(color))
    }

    func border(_ color: UColor) -> some View {
        border(Color(color))
    }
}
