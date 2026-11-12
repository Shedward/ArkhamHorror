//
//  SplitHalfAndZipShuffle.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

extension Shuffles {
	public struct SplitHalfAndZip<Item>: ShuffleStrategy {
		public init() {
		}

		public func shuffle(_ items: [Item]) -> [Item] {
			let chunks = items.chunked(count: 2)
			let maxChunkSize = chunks.map { $0.count }.max()

			guard let maxChunkSize = maxChunkSize, maxChunkSize > 0 else { return items }

			var shuffled: [Item] = []
			(0..<maxChunkSize).forEach { index in
				chunks.forEach { chunk in
					if let item = chunk[safe: index] {
						shuffled.append(item)
					}
				}
			}

			return shuffled
		}
	}
}
