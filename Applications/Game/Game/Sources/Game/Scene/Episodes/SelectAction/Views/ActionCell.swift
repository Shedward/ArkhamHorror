//
//  ActionCell.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2023.
//

import HUD

final class ActionCell: View, CollectionCell {
    static let size = TextButton.defaultSize

    let id: String

    init(data: Data) {
        self.id = data.id

        super.init()

        let textButton = TextButton(text: data.title, onTap: data.onTap)
        addChild(textButton)
    }
}

extension ActionCell {
    struct Data {
        let id: String
        let title: String
        let onTap: () -> Void
    }
}
