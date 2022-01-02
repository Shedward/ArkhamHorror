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
}
