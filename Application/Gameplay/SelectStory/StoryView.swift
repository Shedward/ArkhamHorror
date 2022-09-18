//
//  StoryView.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 18.09.2022.
//

import SwiftUI

struct StoryView: View {
    let title: String

    var body: some View {
        VStack(spacing: 16) {
            Rectangle()
                .aspectRatio(10/16, contentMode: .fit)
                .cornerRadius(16)
                .foregroundColor(Color(.Design.Background.secondary))
            VStack {
                Text(title)
                    .styled(.Design.subtitle)
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
        StoryView(title: "Story title")
    }
}
