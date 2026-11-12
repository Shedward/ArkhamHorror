//
//  DependenciesEnvironmentKey.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SwiftUI
import DesignSystem

struct DependenciesEnvironmentKey: EnvironmentKey {
    static var defaultValue: AllDependencies = MockDependencies()
}

extension EnvironmentValues {
    var dependencies: AllDependencies {
        get { self[DependenciesEnvironmentKey.self] }
        set { self[DependenciesEnvironmentKey.self] = newValue }
    }
}
