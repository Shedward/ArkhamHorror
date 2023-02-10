//
//  MainView.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SwiftUI
import HUD
import Scenes

public struct MainView: SwiftUI.View {
    let size: CGSize = .init(width: 1280, height: 720)

    public init() {
    }

    public var body: some SwiftUI.View {
        SceneView(overlay: HUD.MenuScene(size: size))
            .frame(width: size.width, height: size.height)
    }
}
