//
//  MenuSeparator.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 07.11.2022.
//

import SwiftUI

struct MenuHSeparator: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(.Design.Content.main))
    }
}

struct MenuVSeparator: View {
    var body: some View {
        Rectangle()
            .frame(width: 1)
            .foregroundColor(Color(.Design.Content.main))
    }
}
