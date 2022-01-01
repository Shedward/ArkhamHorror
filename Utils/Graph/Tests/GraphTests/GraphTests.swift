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
}
