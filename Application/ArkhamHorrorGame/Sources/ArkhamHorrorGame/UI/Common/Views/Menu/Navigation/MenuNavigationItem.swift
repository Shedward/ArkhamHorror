//
//  MenuNavigationItem.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI

struct MenuNavigationItem: Equatable, Identifiable {
    let id: UUID
    let view: AnyView?

    init(id: UUID = .init(), view: AnyView) {
        self.id = id
        self.view = view
    }

    static func == (_ lhs: MenuNavigationItem, _ rhs: MenuNavigationItem) -> Bool {
        lhs.id == rhs.id
    }
}
