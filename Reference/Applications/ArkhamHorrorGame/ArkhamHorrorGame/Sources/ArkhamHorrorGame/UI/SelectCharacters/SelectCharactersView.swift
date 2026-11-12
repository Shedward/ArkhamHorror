//
//  SelectCharactersView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import Prelude
import DesignSystem

struct SelectCharactersView: View {

    enum State {
        case selectCharacter
        case configureCharacter
    }

    @Environment(\.design)
    var design: DesignSystem
    @SwiftUI.State
    var state: State = .configureCharacter

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(design.color.background.main)
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
                        .styled(design.text.menu.h2)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(0..<3) { _ in
                                CharacterPortrait(size: .small)
                            }
                        }
                    }
                    MenuButton(title: Localized.string("Start"), icons: .mainButton)
                }
                .padding(.leading, 16)
            }
        }
        .menuProperties(showBackButton: false)
    }
}

struct SelectCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPreview {
            SelectCharactersView(state: .configureCharacter)
        }
    }
}
