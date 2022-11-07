//
//  ConfigureCharacterView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 07.11.2022.
//

import SwiftUI

struct ConfigureCharacterView: View {

    let name: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(spacing: 16) {
                CharacterPortrait(size: .big)
                MenuHSeparator().frame(maxWidth: CharacterPortrait.width(for: .big))
            }
            MenuVSeparator().padding([.top, .bottom])
            VStack {

            }
        }
    }
}

struct ConfigureCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigureCharacterView(
            name: "John Summerfield",
            description: """
            The end is near and John is feeling it
            """
        )
    }
}
