//
//  SplitInHalfAndSwitchShuffle.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

extension Shuffles {
	public struct SplitInHalfAndSwitchShuffle<Item>: ShuffleStrategy {

		public func shuffle(_ items: [Item]) -> [Item] {
			let chunks = items.chunked(count: 2)
			let leftHalf = chunks.first ?? []
			let rightHalf = chunks.last ?? []
			return rightHalf + leftHalf
		}
	}
}
