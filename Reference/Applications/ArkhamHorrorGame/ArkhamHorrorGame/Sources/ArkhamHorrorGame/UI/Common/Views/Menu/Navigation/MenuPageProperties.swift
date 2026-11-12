//
//  File.swift
//  
//
//  Created by Vladislav Maltsev on 27.11.2022.
//

import SwiftUI
import Prelude

struct MenuPageProperties: Equatable, Withable {
    var title: String?
    var showBackButton: Bool

    init(title: String? = nil, showBackButton: Bool = true) {
        self.title = title
        self.showBackButton = showBackButton
    }
}
