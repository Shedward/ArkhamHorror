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
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color(.Design.Background.main))
            VStack(spacing: 32) {
                VStack(spacing: 0) {
                    Text(Localized.string(title))
                        .styled(.Design.title)
                    Rectangle()
                        .frame(maxWidth: 200, maxHeight: 1)
                        .foregroundColor(Color(.Design.Content.main))
                }
                content
            }
            .padding()
        }
    }
}

struct MenuPage_Previews: PreviewProvider {
    static var previews: some View {
        MenuPage(title: "Title") {
            Text("~ Content ~")
                .styled(.Design.title)
        }
    }
}
