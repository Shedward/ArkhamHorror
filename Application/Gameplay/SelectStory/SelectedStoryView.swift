//
//  SelectedStoryView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import Prelude
import ArkhamHorror

struct SelectedStoryView: View {
    let title: String
    let image: UImage
    let description: String

    var body: some View {
        MenuPage(title: title) {
            HStack(spacing: 16) {
                StoryImage()
                VStack {
                    Text(description)
                        .styled(.Design.Menu.body)
                    MenuHSeparator()
                        .frame(maxWidth: 50)
                    MenuButton(
                        title: Localized.string("Start"),
                        highlightingStyle: .mainButton
                    )
                }
                .frame(width: StoryImage.width)
            }
        }
    }
}

struct SelectedStoryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(.Design.Background.main))
            SelectedStoryView(
                title: "Story title",
                image: UImage(),
                description: """
                This is a test for multiline string \
                which we trying to use as \
                test data to check if this view will looks good
                """
            )
        }
    }
}
