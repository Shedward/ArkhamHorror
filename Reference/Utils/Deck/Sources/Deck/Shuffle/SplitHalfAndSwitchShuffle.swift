//
//  SplitInHalfAndSwitchShuffle.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

extension Shuffles {
	public struct SplitHalfAndSwitch<Item>: ShuffleStrategy {
		public init() {
		}

		public func shuffle(_ items: [Item]) -> [Item] {
			let chunks = items.chunked(count: 2)
			let leftHalf = chunks[safe: 0] ?? []
			let rightHalf = chunks[safe: 1] ?? []
			return rightHalf + leftHalf
		}
	}
}
