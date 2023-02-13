//
//  GameApp.swift
//  Game
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SwiftUI
import Game

@main
struct GameApp: App {
    var body: some Scene {
        WindowGroup {
            switch Result { try MainView() } {
            case .success(let mainView):
                mainView
            case .failure(let error):
                Text("Failed to load the app: \(error.localizedDescription)")
            }
        }
    }
}
