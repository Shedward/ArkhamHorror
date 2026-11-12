//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

struct MenuNavigatorEnvironmentKey: EnvironmentKey {
    static var defaultValue = MenuNavigator(pop: { })
}

extension EnvironmentValues {
    var menuNavigator: MenuNavigator {
        get { self[MenuNavigatorEnvironmentKey.self] }
        set { self[MenuNavigatorEnvironmentKey.self] = newValue }
    }
}
