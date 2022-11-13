//
//  MenuPage.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 18.09.2022.
//

import SwiftUI
import Prelude

struct MenuPage<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .center) {
                Rectangle()
                    .fill(Color(.Design.Background.main))
                    .ignoresSafeArea()
                VStack(spacing: 32) {
                    MenuTitle(text: title)
                    content
                        .padding([.leading, .trailing, .bottom], 32)
                }
                .padding()
            }
            MenuButton(title: Localized.string("Back"), icons: .leftIcon("arrow.backward"))
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 24, trailing: 0))
        }
    }
}

struct MenuPage_Previews: PreviewProvider {
    static var previews: some View {
        MenuPage(title: "Title") {
            Text("~ Content ~")
                .styled(.Design.Menu.h1)
        }
    }
}
