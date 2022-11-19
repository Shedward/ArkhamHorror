//
//  DesignSystem+Color.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import SwiftUI

extension DesignSystem {
    enum Color {

        private static func named(_ name: String) -> UColor {
            #if os(iOS)
            UColor(named: name, in: .module, compatibleWith: nil)!
            #elseif os(macOS)
            UColor(named: name, bundle: .module)!
            #endif
        }

        enum Background {
            static let main = Color.named("color.background.main")
            static let secondary = Color.named("color.background.secondary")
            static let tertiary = Color.named("color.background.tertiary")
            static let quaternary = Color.named("color.background.quaternary")
        }

        enum Content {
            static let main = Color.named("color.content.main")
            static let secondary = Color.named("color.content.secondary")
        }

        enum Fixed {
            static let black = Color.named("color.fixed.black")
        }

        enum Tint {
            static let bad = Color.named("color.tint.bad")
            static let good = Color.named("color.tint.good")
        }
    }
}

extension UColor {
    typealias Design = DesignSystem.Color
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
