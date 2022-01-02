//
//  DebugGraphFormatterTests.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

import XCTest
@testable import Graph

final class DebugGraphFormatterTests: XCTestCase {
	let formatter = DebugGraphFormatter<Int>()

	func testValueFormatting() {
		let graph = Graph<Int>()
		let node1 = graph.createNode(1)

		XCTAssertEqual(formatter.formatValue(node: node1), "1")
	}

	func testNodeFormatting() {
		let graph = Graph<Int>()
		let node1 = graph.createNode(1)
		let node2 = graph.createNode(2)
		let node3 = graph.createNode(3)

		node1.connect(to: node2)
		node1.connect(to: node3)

		XCTAssertEqual(
			formatter.format(from: node1),
			"""
			1
			  -> 2
			  -> 3
			"""
		)
	}

	func testGraphFormatting() {
		let graph = Graph<Int>()
		let node1 = graph.createNode(1)
		let node2 = graph.createNode(2)
		let node3 = graph.createNode(3)

		node1.connect(to: node2)
		node1.connectMutually(to: node3)

		XCTAssertEqual(
			formatter.format(from: graph),
			"""
			Graph<Int>
			  1
			    -> 2
			    -> 3
			  2
			  3
			    -> 1
			"""
		)
	}
}


