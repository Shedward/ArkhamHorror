//
//  MainMenuView.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 17.08.2022.
//

import Prelude
import SwiftUI

struct MainMenu: View {
    var body: some View {
        MenuPage(title: Localized.string("Arkham Horror")) {
            VStack(spacing: 8) {
                Text(Localized.string("New game"))
                    .styled(.Design.subtitle)
                Text(Localized.string("Setting"))
                    .styled(.Design.subtitle)
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
