//
//  SelectFlow.swift
//  
//
//  Created by Vladislav Maltsev on 02.05.2023.
//

import Prelude

final class SelectFlow<ID: Hashable, Highlight> {
    private let nodes: [AnySelectableNode<ID, Highlight>]
    private let selectedHighlight: Highlight?
    private let onSelectionChanged: (SelectFlow) -> Void

    private var state: State
    private let logger = Logger()

    init(
        nodes: [AnySelectableNode<ID, Highlight>],
        selectedHighlight: Highlight?,
        onSelectionChanged: @escaping (SelectFlow) -> Void
    ) {
        self.nodes = nodes
        self.selectedHighlight = selectedHighlight
        self.onSelectionChanged = onSelectionChanged
        self.state = .initialized
    }

    func start() {
        guard state == .initialized else { return }

        if nodes.isEmpty {
            logger.warning("""
            Tried to start SelectFlow with empty `nodes`.
            """)
        }
        state = .inProgress
    }

    func finish() {
        guard state == .inProgress else { return }
        state = .finished
    }
}

extension SelectFlow {
    enum State {
        case initialized
        case inProgress
        case finished
    }
}
