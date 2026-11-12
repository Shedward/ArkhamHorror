//
//  AllDependencies.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 19.11.2022.
//

import HUD
import ArkhamHorror
import DesignSystem

typealias NoDependencies = Any

typealias AllDependencies =
    ArkhamHorrorDependencies
    & DesignSystemDependencies
    & HUDDependencies
