//
//  SelectCharactersView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import Prelude

struct SelectCharactersView: View {

    enum State {
        case selectCharacter
        case configureCharacter
    }

    @SwiftUI.State
    var state: State = .selectCharacter

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.init(.Design.Background.main))
                .ignoresSafeArea()
            HStack(alignment: .bottom, spacing: 16) {
                switch state {
                case .selectCharacter:
                    CharactersList()
                case .configureCharacter:
                    ConfigureCharacterView.mock()
                }
                MenuVSeparator()
                VStack(spacing: 16) {
                    Text(Localized.string("2/4"))
                        .styled(.Design.Menu.h2)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(0..<3) { _ in
                                CharacterPortrait(size: .small)
                            }
                        }
                    }
                    MenuButton(title: Localized.string("Start"), icons: .mainButton)
                }
                .padding([.leading, .trailing], 16)
            }
            .padding(24)
        }
    }
}

struct SelectCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCharactersView(state: .configureCharacter)
    }
}
