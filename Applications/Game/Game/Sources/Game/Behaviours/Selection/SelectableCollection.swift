//
//  SelectableCollection.swift
//  
//
//  Created by Vladislav Maltsev on 02.05.2023.
//

import Prelude

final class SelectableCollection<ID: Hashable, Highlight> {
    private var nodes: [AnySelectableNode<ID, Highlight>]

    init(nodes: [AnySelectableNode<ID, Highlight>]) {
        self.nodes = nodes
    }

    private func select(
        in availableIds: [ID]? = nil,
        count: Int? = nil,
        selectedHighlight: Highlight? = nil,
        onSelectionChanged: (SelectFlow<ID, Highlight>) -> Void
    ) -> SelectFlow<ID, Highlight> {
        notImplemented()
    }
}
