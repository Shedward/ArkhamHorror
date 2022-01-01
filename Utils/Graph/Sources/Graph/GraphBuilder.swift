//
//  GraphBuilder.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public struct GraphBuilder<T> {
	private let graph: Graph<T>

	public init(graph: Graph<T>) {
		self.graph = graph
	}

	public func createChain(_ values: [T]) -> [Node<T>] {
		createChain(values, mutually: false)
	}

	public func createBidirectionalChain(_ values: [T]) -> [Node<T>] {
		createChain(values, mutually: true)
	}

	public func createRing(_ values: [T]) -> [Node<T>] {
		let chain = createChain(values)
		if let first = chain.first {
			chain.last?.connect(to: first)
		}
		return chain
	}

	public func createBidirectionalRing(_ values: [T]) -> [Node<T>] {
		let chain = createBidirectionalChain(values)
		if let first = chain.first {
			chain.last?.connectMutually(to: first)
		}
		return chain
	}

	private func createChain(_ values: [T], mutually: Bool) -> [Node<T>] {
		let nodes = values.map(graph.createNode(_:))
		nodes.indices.forEach { index in
			let nextIndex = index + 1
			guard nodes.indices.contains(nextIndex) else { return }
			if mutually {
				nodes[index].connectMutually(to: nodes[nextIndex])
			} else {
				nodes[index].connect(to: nodes[nextIndex])
			}
		}
		return nodes
	}
}
