//
//  ArkhamHorrorGame.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI
import MapScene

public struct ArkhamHorrorGameApp: View {

    public init() {
    }

    public var body: some View {
        MenuContainer {
            LoadMapView()
        }
    }
}
