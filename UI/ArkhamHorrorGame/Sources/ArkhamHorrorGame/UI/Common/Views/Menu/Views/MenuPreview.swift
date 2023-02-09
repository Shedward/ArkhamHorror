//
//  MenuPreview.swift
//  
//
//  Created by Vladislav Maltsev on 04.12.2022.
//

import SwiftUI

struct MenuPreview<Content: View>: View {
    @Environment(\.design)
    var design: DesignSystem

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        Rectangle()
            .foregroundColor(design.color.background.main)
        content
            .padding(32)
    }
}
