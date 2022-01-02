//
//  GraphTests.swift
//
//
//  Created by Vladislav Maltsev on 02.01.2022.
//
import XCTest
import Graph

final class GraphTests: XCTestCase {
    func testConnection() {
		let graph = Graph<Int>()
		let node1 = graph.createNode(1)
		let node2 = graph.createNode(2)
		let node3 = graph.createNode(3)
		node1.connectMutually(to: node2)
		node2.connect(to: node3)

		XCTAssert(node1.isNeighbor(to: node2))
		XCTAssert(node2.isNeighbor(to: node1))
		XCTAssert(node2.isNeighbor(to: node3))
		XCTAssertNotNil(node2.neighbor(for: 3))

		XCTAssertFalse(node3.isNeighbor(to: node2))
		XCTAssertFalse(node3.isNeighbor(to: node1))
    }

	func testDeletion() {
		let graph = Graph<Int>()
		let node1 = graph.createNode(1)
		let node2 = graph.createNode(2)
		let node3 = graph.createNode(3)
		node1.connectMutually(to: node2)
		node2.connect(to: node3)


		graph.deleteNode(node2)
		XCTAssertEqual(node1.neighbors.count, 0)
		XCTAssertEqual(node3.neighbors.count, 0)
		XCTAssertNil(graph.node(for: 2))
	}

	func testSearchByValue() {
		let graph = Graph<Int>()
		let node1 = graph.createNode(1)
		let node2 = graph.createNode(2)
		let node3 = graph.createNode(3)
		node1.connectMutually(to: node2)
		node2.connect(to: node3)

		XCTAssertNotNil(graph.node(for: 3))
		XCTAssertNil(graph.node(for: 4))
	}

	func testConnectionFailures() {
		let graphA = Graph<Int>()
		let graphB = Graph<Int>()

		let nodeA1 = graphA.createNode(1)
		let nodeA2 = graphA.createNode(2)

		let nodeB1 = graphB.createNode(1)

		XCTAssertEqualDescription(nodeA1.connect(to: nodeA2), "success()")
		XCTAssertEqualDescription(nodeA1.connect(to: nodeA2), "failure(Graph.NodeConnectionError.nodesAlreadyConnected)")
		XCTAssertEqualDescription(nodeA1.connect(to: nodeA1), "failure(Graph.NodeConnectionError.nodeCannotConnectToItself)")
		XCTAssertEqualDescription(nodeA1.connect(to: nodeB1), "failure(Graph.NodeConnectionError.nodesFromDifferentGraphs)")
	}

	@available(macOS 10.15, *)
	func testIdentifiableHelpers() {
		struct IdentifiableStruct: Identifiable, Equatable {
			var id: Int
			var name: String
		}

		let graph = Graph<IdentifiableStruct>()

		let node1 = graph.createNode(.init(id: 1, name: "One"))
		let node2 = graph.createNode(.init(id: 2, name: "Two"))
		let node3 = graph.createNode(.init(id: 3, name: "Three"))
		let node4 = graph.createNode(.init(id: 4, name: "Four"))

		node1.connect(to: node2)
		node1.connect(to: node3)
		node2.connect(to: node4)

		XCTAssertNotNil(graph.node(for: 2))
		XCTAssertEqual(graph.node(for: 2)?.value.name, "Two")
		XCTAssertNotNil(node1.neighbor(for: 2))

		XCTAssertNotNil(graph.node(for: 4))
		XCTAssertNil(node1.neighbor(for: 4))
	}
}

private func XCTAssertEqualDescription<T>(_ t: T, _ description: String, file: StaticString = #filePath, line: UInt = #line) {
	XCTAssertEqual(String(describing: t), description, file: file, line: line)
}
