//
//  AnyShuffle.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public struct AnyShuffle<Item>: ShuffleStrategy {
	private let wrappedShuffle: ([Item]) -> [Item]

	public init<Wrapped: ShuffleStrategy>(_ wrapped: Wrapped) where Wrapped.Item == Item {
		wrappedShuffle = wrapped.shuffle(_:)
	}

	public func shuffle(_ items: [Item]) -> [Item] {
		wrappedShuffle(items)
	}
}
