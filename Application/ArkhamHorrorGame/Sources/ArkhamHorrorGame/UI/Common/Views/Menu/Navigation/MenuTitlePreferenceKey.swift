//
//  MenuTitlePreferenceKey.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

struct MenuTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String? = nil

    typealias Value = String?

    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue() ?? value
    }
}

extension View {
    func menuTitle(_ string: String) -> some View {
        preference(key: MenuTitlePreferenceKey.self, value: string)
    }
}
