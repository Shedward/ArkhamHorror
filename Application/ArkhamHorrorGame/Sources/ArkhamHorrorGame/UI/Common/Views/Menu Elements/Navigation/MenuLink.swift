//
//  MenuLink.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

struct MenuLink<Link: View, Content: View>: View {
    let id: UUID
    let link: Link
    let content: Content

    @State
    private var selectedLink: MenuNavigationItem?

    init(@ViewBuilder link: () -> Link, @ViewBuilder content: () -> Content) {
        self.id = UUID()
        self.link = link()
        self.content = content()
    }

    var body: some View {
        link
            .preference(key: MenuNavigationPreferenceKey.self, value: selectedLink)
            .onTapGesture {
                selectedLink = MenuNavigationItem(id: id, view: AnyView(content))
            }
    }
}
