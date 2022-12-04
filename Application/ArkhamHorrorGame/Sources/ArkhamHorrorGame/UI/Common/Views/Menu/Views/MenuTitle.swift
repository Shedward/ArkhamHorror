//
//  MenuTitle.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI

struct MenuTitle: View {
    @Environment(\.design)
    var design: DesignSystem

    let text: String

    var body: some View {
        VStack(spacing: 0) {
            Text(text)
                .styled(design.text.menu.h1)
            MenuHSeparator().frame(maxWidth: 200)
        }
    }
}

struct MenuTitle_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitle(text: "Menu Title")
    }
}
