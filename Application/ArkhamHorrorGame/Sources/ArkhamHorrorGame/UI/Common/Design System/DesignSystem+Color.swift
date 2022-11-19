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
            static let main = UColor(named: "color.background.main", bundle: .module)!
            static let secondary = UColor(named: "color.background.secondary", bundle: .module)!
            static let tertiary = UColor(named: "color.background.tertiary", bundle: .module)!
            static let quaternary = UColor(named: "color.background.quaternary", bundle: .module)!
        }

        enum Content {
            static let main = UColor(named: "color.content.main", bundle: .module)!
            static let secondary = UColor(named: "color.content.secondary", bundle: .module)!
        }

        enum Fixed {
            static let black = UColor(named: "color.fixed.black", bundle: .module)!
        }

        enum Tint {
            static let bad = UColor(named: "color.tint.bad", bundle: .module)!
            static let good = UColor(named: "color.tint.good", bundle: .module)!
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
