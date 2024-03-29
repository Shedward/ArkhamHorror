//
//  StoryImage.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 06.11.2022.
//

import SwiftUI
import DesignSystem

struct StoryImage: View {
    @Environment(\.design)
    var design: DesignSystem

    static let width = 160.0

    var body: some View {
        Rectangle()
            .aspectRatio(10/16, contentMode: .fit)
            .cornerRadius(16)
            .foregroundColor(design.color.background.secondary)
            .frame(width: StoryImage.width)
    }
}
