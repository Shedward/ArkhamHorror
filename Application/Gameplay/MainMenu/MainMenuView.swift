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
        ZStack(alignment: .center) {
            Rectangle()
                .background(Color(.Design.Background.main))
            VStack(spacing: 32) {
                VStack(spacing: 0) {
                Text(Localized.string("Arkham Horror"))
                    .styled(.Design.title)
                Rectangle()
                    .frame(maxWidth: 200, maxHeight: 1)
                    .foregroundColor(Color(.Design.Content.main))
                }
                VStack {
                    Text(Localized.string("New game"))
                        .styled(.Design.subtitle)
                    Text(Localized.string("Load game"))
                        .styled(.Design.subtitle)
                }
            }
            .padding()
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
