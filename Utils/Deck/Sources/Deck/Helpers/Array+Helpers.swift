//
//  Array+Helpers.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

extension Array {

	/// Split array into chunks by specified size.
	///
	/// If items count is less than `N * size` last chunk
	/// will contain less than `size` items.
	/// - Examples:
	///	```
	///	[].chunked(by: 2) == []
	///	[1].chunked(by: 2) == [[1]]
	///	[1, 2, 3, 4].chunked(by: 2) == [[1, 2], [3, 4]]
	///	[1, 2, 3, 4, 5].chunked(by: 2) == [[1, 2], [3, 4], [5]]
	///	```
	/// - Parameter size: Max size of chunk
	/// - Returns: Array of chunks.
	func chunked(by size: Int) -> [[Element]] {
		assert(size > 0, "Chunk size should be more than zero.")
		return stride(from: 0, to: count, by: size).map {
			Array(self[$0 ..< Swift.min($0 + size, count)])
		}
	}

	func chunked(count: Int) -> [[Element]] {
		assert(count > 0, "Chunk count should be more than zero.")
		let chunkSize = Int((Float(self.count) / Float(count)).rounded(.up))
		return chunked(by: chunkSize)
	}

	/// Split array into `count` number of group.
	///
	/// Groups are filled sequentially.
	/// If items count is less than `count` this method
	/// will return empty arrays for unpopulated groups.
	/// - Examples:
	///	```
	///	[].spreadIntoGroups(count: 3) == [[], [], []]
	///	[1].spreadIntoGroups(count: 3) == [[1], [], []]
	///	[1, 2, 3, 4].spreadIntoGroups(count: 3) == [[1, 4], [2], [3]]
	///	[1, 2, 3, 4, 5, 6].spreadIntoGroups(count: 3) == [[1, 4], [2, 5], [3, 6]]
	///	```
	/// - Parameter count: Count of groups.
	/// - Returns: Array of groups.
	func spreadIntoGroups(count: Int) -> [[Element]] {
		assert(count >= 0, "Group count can not be negative")

		guard count > 0 else { return [] }

		var groups = [[Element]](repeating: [], count: count)
		enumerated().forEach { index, item in
			groups[index % groups.count].append(item)
		}
		return groups
	}
}
