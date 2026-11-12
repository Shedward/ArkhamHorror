//
//  DesignSystemEnvironmentKey.swift
//  
//
//  Created by Vladislav Maltsev on 04.12.2022.
//

import SwiftUI

private struct DesignSystemEnvironmentKey: EnvironmentKey {
    static let defaultValue = DesignSystem.default
}

extension EnvironmentValues {
    public var design: DesignSystem {
        get { self[DesignSystemEnvironmentKey.self] }
        set { self[DesignSystemEnvironmentKey.self] = newValue }
    }
}
