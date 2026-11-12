//
//  MenuButtonsPreferenceKey.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

struct MenuPagePropertiesPreferenceKey: PreferenceKey {
    static var defaultValue: MenuPageProperties?

    typealias Value = MenuPageProperties?

    static func reduce(value: inout MenuPageProperties?, nextValue: () -> MenuPageProperties?) {
        value = nextValue() ?? value
    }
}

extension View {
    func menuProperties(title: String? = nil, showBackButton: Bool = true) -> some View {
        preference(
            key: MenuPagePropertiesPreferenceKey.self,
            value: .init(title: title, showBackButton: showBackButton)
        )
    }
}
