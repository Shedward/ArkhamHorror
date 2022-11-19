//
//  MainMenuView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 17.08.2022.
//

import Prelude
import SwiftUI

public struct MainMenu: View {

    public init() {
    }

    public var body: some View {
        MenuPage(title: Localized.string("Arkham Horror")) {
            VStack(spacing: 8) {
                NavigationLink {
                    SelectCharactersView()
                } label: {
                    MenuButton(title: Localized.string("New game"), icons: .mainButton)
                }
                NavigationLink {
                    MenuPage(title: Localized.string("Settings")) {
                        UnderConstructionView(textStyle: .Design.Menu.h1)
                    }
                } label: {
                    MenuButton(title: Localized.string("Settings"))
                }
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
