//
//  ConfigureCharacterView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 07.11.2022.
//

import SwiftUI

struct ConfigureCharacterView: View {

    let name: String
    let profession: String
    let story: String

    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            VStack(spacing: 12) {
                CharacterPortrait(size: .big)
                VStack {
                    Text(name)
                        .styled(.Design.Menu.h3)
                    Text(profession)
                        .styled(.Design.Menu.story)
                }
                MenuHSeparator()
                    .frame(maxWidth: 50)
                Text(story)
                    .styled(.Design.Menu.story)
            }
            .frame(maxWidth: CharacterPortrait.width(for: .big) * 1.25)
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
            profession: "Policeman",
            story: """
            The end is near and John is feeling it. It's been a long time\
            since he feelt anything else than morbid horror of existence in\
            this world with cruel
            """
        )
        .padding()
        .background(Color(.Design.Background.main))
    }
}
