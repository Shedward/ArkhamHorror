//
//  AnimationQueue.swift
//  
//
//  Created by Vladislav Maltsev on 04.03.2023.
//

public final class AnimationQueue {
    private var transactions: [AnimationTransaction] = []

    public init() {
    }

    public func enqueue(_ actions: () throws -> Void) rethrows {
        let transaction = AnimationTransaction()
        AnimationTransaction.current = transaction
        try actions()
        AnimationTransaction.current = nil

        Task {
            for action in transaction.enqueuedActions {
                await action.run()
            }
        }
    }
}

final class AnimationTransaction {
    static var current: AnimationTransaction?

    private(set) var enqueuedActions: [AnimationQueueAction] = []

    func enqueueAction(_ action: AnimationQueueAction) {
        enqueuedActions.append(action)
    }
}
