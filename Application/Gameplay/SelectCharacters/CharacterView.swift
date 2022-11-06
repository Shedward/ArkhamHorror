//
//  CharacterView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

struct CharacterView: View {
    let name: String

    var body: some View {
        VStack {
            CharacterPortrait()
            Text(name)
                .styled(.Design.menuBody)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(height: 32, alignment: .top)
                .frame(maxWidth: CharacterPortrait.width * 1.5)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(name: "Joe Doe")
    }
}
