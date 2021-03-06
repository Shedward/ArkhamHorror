//
//  ArrayHelpersTests.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import XCTest
@testable import Deck

final class ArrayHeplersTests: XCTestCase {
	func testChunkedBySize() {
		XCTAssertEqual([Int]().chunked(by: 2), [])
		XCTAssertEqual([1].chunked(by: 2), [[1]])
		XCTAssertEqual([1, 2, 3, 4].chunked(by: 2), [[1, 2], [3, 4]])
		XCTAssertEqual([1, 2, 3, 4, 5].chunked(by: 2), [[1, 2], [3, 4], [5]])
	}

	func testChunkedByCount() {
		let array = [1, 2, 3, 4, 5]
		XCTAssertEqual(array.chunked(count: 2), [[1, 2, 3], [4, 5]])
		XCTAssertEqual(array.chunked(count: 3), [[1, 2], [3, 4], [5]])
		XCTAssertEqual(array.chunked(count: 4), [[1, 2], [3, 4], [5]]) // This is probably wrong
		XCTAssertEqual(array.chunked(count: 5), [[1], [2], [3], [4], [5]])
	}

	func testSpreadIntoGroups() {
		XCTAssertEqual([Int]().spreadIntoGroups(count: 3), [[], [], []])
		XCTAssertEqual([1].spreadIntoGroups(count: 3), [[1], [], []])
		XCTAssertEqual([1, 2, 3, 4].spreadIntoGroups(count: 3), [[1, 4], [2], [3]])
		XCTAssertEqual([1, 2, 3, 4, 5, 6].spreadIntoGroups(count: 3), [[1, 4], [2, 5], [3, 6]])
		XCTAssertEqual([1, 2, 3].spreadIntoGroups(count: 0), [])
		XCTAssertEqual([1, 2, 3].spreadIntoGroups(count: 1), [[1, 2, 3]])
	}

	func testSafeSubscribe() {
		let immutableArray = [0, 1, 2, 3]
		XCTAssertEqual(immutableArray[safe: 2], 2)
		XCTAssertEqual(immutableArray[safe: 6], nil)

		var array = [0, 1, 2, 3]
		XCTAssertEqual(array[safe: 2], 2)
		XCTAssertEqual(array[safe: 6], nil)

		array[safe: 6] = 6
		XCTAssertEqual(array, [0, 1, 2, 3])

		array[safe: 3] = -3
		XCTAssertEqual(array, [0, 1, 2, -3])
	}
}
