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
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.init(.Design.Background.main))
            HStack(alignment: .bottom, spacing: 16) {
                CharactersList()
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.init(.Design.Content.main))
                VStack(spacing: 16) {
                    Text(Localized.string("2/4"))
                        .styled(.Design.menuSubtitle)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(0..<3) { _ in
                                CharacterPortrait()
                            }
                        }
                    }
                    MenuButton(title: Localized.string("Start"), highlightingStyle: .mainButton)
                }
            }
            .padding(24)
        }
    }
}

struct SelectCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCharactersView()
    }
}
