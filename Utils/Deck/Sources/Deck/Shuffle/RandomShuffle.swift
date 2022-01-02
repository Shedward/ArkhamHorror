//
//  RandomShuffle.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

extension Shuffles {
	public struct Random<Item>: ShuffleStrategy {
		public init() {
		}

		public func shuffle(_ items: [Item]) -> [Item] {
			items.shuffled()
		}
	}
}
