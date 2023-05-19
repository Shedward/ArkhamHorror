//
//  Fn.swift
//  
//
//  Created by Vladislav Maltsev on 22.02.2023.
//

public typealias Action = () -> Void

public struct ActionsStack {
    private var actions: [() -> Void]

    public init() {
        actions = []
    }

    public mutating func push(_ action: @escaping () -> Void) {
        actions.append(action)
    }

    public mutating func pop() {
        _ = actions.popLast()
    }

    public func call() {
        actions.last?()
    }
}
