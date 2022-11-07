//
//  MenuTitle.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

struct MenuTitle: View {
    let text: String

    var body: some View {
        VStack(spacing: 0) {
            Text(text)
                .styled(.Design.menuTitle)
            MenuHSeparator().frame(maxWidth: 200)
        }
    }
}

struct MenuTitle_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitle(text: "Menu Title")
    }
}
