//
//  MainMenuView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 17.08.2022.
//

import Prelude
import SwiftUI
import DesignSystem

struct MainMenu: View {

    @Environment(\.design)
    var design: DesignSystem

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
                UnderConstructionView(textKind: \.menu.h1)
                    .menuProperties(title: Localized.string("Settings"))
            }
        }
        .menuProperties(title: Localized.string("Arkham Horror"))
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
