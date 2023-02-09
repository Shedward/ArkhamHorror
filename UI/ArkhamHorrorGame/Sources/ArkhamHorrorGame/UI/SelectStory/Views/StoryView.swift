//
//  StoryView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 18.09.2022.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.design)
    var design: DesignSystem

    let title: String

    var body: some View {
        VStack(spacing: 16) {
            StoryImage()
            VStack {
                Text(title)
                    .styled(design.text.menu.h4)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Spacer()
            }
            .frame(height: 64)
        }
        .frame(maxWidth: 160)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPreview {
            StoryView(title: "Story title")
        }
    }
}
