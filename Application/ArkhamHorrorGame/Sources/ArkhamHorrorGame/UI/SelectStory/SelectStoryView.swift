//
//  SelectStoryView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 18.09.2022.
//

import SwiftUI
import Prelude

struct SelectStoryView: View {
    struct MockStory: Identifiable {
        let id: String
        let title: String
    }

    let stories: [MockStory]

    var body: some View {
        MenuPage(title: Localized.string("Select story")) {
            HStack(spacing: 32) {
                ForEach(stories) { story in
                    StoryView(title: story.title)
                }
            }
        }
    }
}

struct SelectStory_Previews: PreviewProvider {
    static var previews: some View {
        SelectStoryView(
            stories: [
                .init(id: "1", title: "Multiline\n title"),
                .init(id: "2", title: "Long title to check moving to different line"),
                .init(id: "3", title: "Faling Form")
            ]
        )
    }
}
