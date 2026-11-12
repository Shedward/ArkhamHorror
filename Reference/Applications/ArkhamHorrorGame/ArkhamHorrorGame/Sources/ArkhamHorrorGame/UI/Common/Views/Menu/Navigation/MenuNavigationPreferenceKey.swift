//
//  MenuNavigationPreferenceKey.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

struct MenuNavigationPreferenceKey: PreferenceKey {
    static var defaultValue: MenuNavigationItem? = nil

    typealias Value = MenuNavigationItem?

    static func reduce(value: inout MenuNavigationItem?, nextValue: () -> MenuNavigationItem?) {
        value = nextValue() ?? value
    }
}
