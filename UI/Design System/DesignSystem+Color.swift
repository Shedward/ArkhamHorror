//
//  DesignSystem+Color.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

import SwiftUI

extension DesignSystem {
    enum Color {
        enum Background {
            static let main = UColor(named: "color.background.main")!
            static let secondary = UColor(named: "color.background.secondary")!
            static let tertiary = UColor(named: "color.background.tertiary")!
            static let quaternary = UColor(named: "color.background.quaternary")!
        }

        enum Content {
            static let main = UColor(named: "color.content.main")!
            static let secondary = UColor(named: "color.content.secondary")!
        }

        enum Fixed {
            static let black = UColor(named: "color.fixed.black")!
        }

        enum Tint {
            static let bad = UColor(named: "color.tint.bad")!
            static let good = UColor(named: "color.tint.good")!
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
