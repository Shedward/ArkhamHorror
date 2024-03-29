//
//  SelectedStoryView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import Prelude
import ArkhamHorror
import DesignSystem

struct SelectedStoryView: View {

    @Environment(\.design)
    var design: DesignSystem

    let title: String
    let image: UImage
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            StoryImage()
            VStack {
                Text(description)
                    .styled(design.text.menu.body)
                MenuHSeparator()
                    .frame(maxWidth: 50)
                MenuButton(
                    title: Localized.string("Start"),
                    icons: .mainButton
                )
            }
            .frame(width: StoryImage.width)
        }
        .menuProperties(title: title)
    }
}

struct SelectedStoryView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPreview {
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
