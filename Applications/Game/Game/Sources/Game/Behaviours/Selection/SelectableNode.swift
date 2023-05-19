//
//  SelectableNode.swift
//  
//
//  Created by Vladislav Maltsev on 02.05.2023.
//

import Prelude
import Scenes

protocol SelectableNode: Identifiable, AnyObject {
    associatedtype Highlight

    var id: ID { get }
    var highlight: Highlight? { get set }
    var onSelectActions: ActionsStack { get set }
}

class AnySelectableNode<ID: Hashable, Highlight>: SelectableNode {
    private let getId: () -> ID
    private let getHighlight: () -> Highlight?
    private let setHighlight: (Highlight?) -> Void
    private let getOnSelectActions: () -> (ActionsStack)
    private let setOnSelectActions: (ActionsStack) -> Void

    var id: ID {
        getId()
    }

    var highlight: Highlight? {
        get { getHighlight() }
        set { setHighlight(newValue) }
    }

    var onSelectActions: ActionsStack {
        get { getOnSelectActions() }
        set { setOnSelectActions(newValue) }
    }

    init<Wrapped: SelectableNode>(
        _ wrapped: Wrapped
    ) where Wrapped.ID == ID, Wrapped.Highlight == Highlight {
        self.getId = { wrapped.id }
        self.getHighlight = { wrapped.highlight }
        self.setHighlight = { wrapped.highlight = $0 }
        self.getOnSelectActions = { wrapped.onSelectActions }
        self.setOnSelectActions = { wrapped.onSelectActions = $0 }
    }
}
