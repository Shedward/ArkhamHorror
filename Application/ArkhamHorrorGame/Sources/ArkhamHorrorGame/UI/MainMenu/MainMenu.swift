//
//  MainMenuView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 17.08.2022.
//

import Prelude
import SwiftUI

struct MainMenu: View {

    var body: some View {
        VStack(spacing: 8) {
            MenuLink {
                MenuButton(title: Localized.string("New game"), icons: .mainButton)
            } content: {
                SelectCharactersView()
            }

            MenuLink {
                MenuButton(title: Localized.string("Settings"))
            } content: {
                UnderConstructionView(textStyle: .Design.Menu.h1)
                    .menuTitle(Localized.string("Settings"))
            }
        }
        .menuTitle(Localized.string("Arkham Horror"))
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
