//
//  CharactersList.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import Prelude

struct CharactersList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            MenuTitle(text: Localized.string("Select characters"))
                .frame(maxWidth: .infinity)
            HStack(spacing: 16) {
                ForEach(0..<4) { _ in
                    VStack(spacing: 16) {
                        ForEach(0..<3) { _ in
                            CharacterView(name: "John Summerfield")
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            MenuButton(iconName: "arrow.backward", title: Localized.string("Back"))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct CharactersList_Previews: PreviewProvider {
    static var previews: some View {
        CharactersList()
    }
}
