//
//  SelectCharactersView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import Prelude

struct SelectCharactersView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundColor(.init(.Design.Background.main))
            HStack(alignment: .bottom, spacing: 16) {
                VStack {
                    MenuTitle(text: Localized.string("Select characters"))
                    HStack(spacing: 16) {
                        ForEach(0..<4) { _ in
                            VStack(spacing: 16) {
                                ForEach(0..<3) { _ in
                                    CharacterPortrait()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.init(.Design.Content.main))
                VStack {
                    Text(Localized.string("2/4"))
                        .styled(.Design.menuSubtitle)
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<3) { _ in
                            CharacterPortrait()
                        }
                    }
                    MenuButton(title: Localized.string("Go"), highlightingStyle: .mainButton)
                }
            }
            .padding(24)
            MenuButton(iconName: "arrow.backward", title: Localized.string("Back"))
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 24, trailing: 0))
        }
    }
}

struct SelectCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCharactersView()
    }
}
