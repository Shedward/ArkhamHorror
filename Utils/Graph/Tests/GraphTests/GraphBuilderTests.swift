//
//  GraphBuilderTests.swift
//
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

import XCTest
import Graph

final class GraphBuilderTests: XCTestCase {
	func testChain() {
		let graph = Graph<Int>()
		let chain = GraphBuilder(graph: graph).createChain(Array(0...5))

		XCTAssertTrue(chain[1].isNeighbor(to: chain[2]))
		XCTAssertFalse(chain[2].isNeighbor(to: chain[1]))

		XCTAssertFalse(chain[5].isNeighbor(to: chain[0]))
	}

	func testBidirectionalChain() {
		let graph = Graph<Int>()
		let chain = GraphBuilder(graph: graph).createBidirectionalChain(Array(0...5))

		XCTAssertTrue(chain[1].isNeighbor(to: chain[2]))
		XCTAssertTrue(chain[2].isNeighbor(to: chain[1]))

		XCTAssertFalse(chain[5].isNeighbor(to: chain[0]))
	}

	func testRing() {
		let graph = Graph<Int>()
		let ring = GraphBuilder(graph: graph).createRing(Array(0...5))

		XCTAssertTrue(ring[1].isNeighbor(to: ring[2]))
		XCTAssertFalse(ring[2].isNeighbor(to: ring[1]))

		XCTAssertTrue(ring[5].isNeighbor(to: ring[0]))
	}

	func testBidirectionalRing() {
		let graph = Graph<Int>()
		let ring = GraphBuilder(graph: graph).createBidirectionalRing(Array(0...5))

		XCTAssertTrue(ring[1].isNeighbor(to: ring[2]))
		XCTAssertTrue(ring[2].isNeighbor(to: ring[1]))

		XCTAssertTrue(ring[5].isNeighbor(to: ring[0]))
		XCTAssertTrue(ring[0].isNeighbor(to: ring[5]))
	}

	func testBridge() {
		let graph = Graph<Int>()
		let nodes = (0...3).map { graph.createNode($0) }
		let bridge = GraphBuilder(graph: graph).createBridge(
			_: -1,
			from: [0, 1],
			to: [2, 3]
		)

		XCTAssertTrue(nodes[0].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[1].isNeighbor(to: bridge))
		XCTAssertFalse(nodes[2].isNeighbor(to: bridge))
		XCTAssertFalse(nodes[3].isNeighbor(to: bridge))
		XCTAssertFalse(bridge.isNeighbor(to: nodes[0]))
		XCTAssertFalse(bridge.isNeighbor(to: nodes[1]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[2]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[3]))
	}

	func testBidirectionalBridge() {
		let graph = Graph<Int>()
		let nodes = (0...3).map { graph.createNode($0) }
		let bridge = GraphBuilder(graph: graph).createBidirectionalBridge(
			_: -1,
			from: [0, 1],
			to: [2, 3]
		)

		XCTAssertTrue(nodes[0].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[1].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[2].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[3].isNeighbor(to: bridge))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[0]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[1]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[2]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[3]))
	}

	private struct IdentifiableInt: Identifiable {
		var id: Int
	}

	func testIdentifiableBridge() {
		let graph = Graph<IdentifiableInt>()
		let nodes = (0...3)
			.map(IdentifiableInt.init(id:))
			.map { graph.createNode($0) }

		let bridge = GraphBuilder(graph: graph).createBridge(
			_: .init(id: -1),
			from: [0, 1],
			to: [2, 3]
		)

		XCTAssertTrue(nodes[0].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[1].isNeighbor(to: bridge))
		XCTAssertFalse(nodes[2].isNeighbor(to: bridge))
		XCTAssertFalse(nodes[3].isNeighbor(to: bridge))
		XCTAssertFalse(bridge.isNeighbor(to: nodes[0]))
		XCTAssertFalse(bridge.isNeighbor(to: nodes[1]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[2]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[3]))
	}

	func testIdentifiableBidirectionalBridge() {
		let graph = Graph<IdentifiableInt>()
		let nodes = (0...3)
			.map(IdentifiableInt.init(id:))
			.map { graph.createNode($0) }

		let bridge = GraphBuilder(graph: graph).createBidirectionalBridge(
			_: .init(id: -1),
			from: [0, 1],
			to: [2, 3]
		)

		XCTAssertTrue(nodes[0].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[1].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[2].isNeighbor(to: bridge))
		XCTAssertTrue(nodes[3].isNeighbor(to: bridge))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[0]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[1]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[2]))
		XCTAssertTrue(bridge.isNeighbor(to: nodes[3]))
	}
}
