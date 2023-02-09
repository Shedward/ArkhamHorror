//
//  DesignSystemEnvironmentKey.swift
//  
//
//  Created by Vladislav Maltsev on 04.12.2022.
//

import SwiftUI

struct DesignSystemEnvironmentKey: EnvironmentKey {
    static var defaultValue = DesignSystem.default
}

extension EnvironmentValues {
    var design: DesignSystem {
        get { self[DesignSystemEnvironmentKey.self] }
        set { self[DesignSystemEnvironmentKey.self] = newValue }
    }
}
