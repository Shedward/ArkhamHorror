//
//  MenuSeparator.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 07.11.2022.
//

import SwiftUI
import DesignSystem

struct MenuHSeparator: View {
    @Environment(\.design)
    var design: DesignSystem

    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(design.color.content.main)
    }
}

struct MenuVSeparator: View {
    @Environment(\.design)
    var design: DesignSystem

    var body: some View {
        Rectangle()
            .frame(width: 1)
            .foregroundColor(design.color.content.main)
    }
}
