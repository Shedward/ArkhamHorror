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

	@discardableResult
	public func createChain(_ values: [T]) -> [Node<T>] {
		createChain(values, mutually: false)
	}

	@discardableResult
	public func createBidirectionalChain(_ values: [T]) -> [Node<T>] {
		createChain(values, mutually: true)
	}

	@discardableResult
	public func createRing(_ values: [T]) -> [Node<T>] {
		let chain = createChain(values)
		if let first = chain.first {
			chain.last?.connect(to: first)
		}
		return chain
	}

	@discardableResult
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

	fileprivate func createBridge(
		_ bridgeValue: T,
		from fromNodes: [Node<T>],
		to toNodes: [Node<T>],
		mutually: Bool
	) -> Node<T> {
		let bridgeNode = graph.createNode(bridgeValue)
		if mutually {
			(fromNodes + toNodes).forEach { node in
				bridgeNode.connectMutually(to: node)
			}
		} else {
			fromNodes.forEach { fromNode in
				fromNode.connect(to: bridgeNode)
			}
			toNodes.forEach { toNode in
				bridgeNode.connect(to: toNode)
			}
		}
		return bridgeNode
	}
}

extension GraphBuilder where T: Equatable {
	@discardableResult
	public func createBridge(_ bridgeValue: T, from: [T], to: [T]) -> Node<T> {
		createBridge(
			bridgeValue,
			from: from.compactMap { graph.node(for: $0) },
			to: to.compactMap { graph.node(for: $0) },
			mutually: false
		)
	}

	@discardableResult
	public func createBidirectionalBridge(_ bridgeValue: T, from: [T], to: [T]) -> Node<T> {
		createBridge(
			bridgeValue,
			from: from.compactMap { graph.node(for: $0) },
			to: to.compactMap { graph.node(for: $0) },
			mutually: true
		)
	}
}

@available(macOS 10.15, iOS 13.0, *)
extension GraphBuilder where T: Identifiable {
	@discardableResult
	public func createBridge(_ bridgeValue: T, from: [T.ID], to: [T.ID]) -> Node<T> {
		createBridge(
			bridgeValue,
			from: from.compactMap { graph.node(for: $0) },
			to: to.compactMap { graph.node(for: $0) },
			mutually: false
		)
	}

	@discardableResult
	public func createBidirectionalBridge(_ bridgeValue: T, from: [T.ID], to: [T.ID]) -> Node<T> {
		createBridge(
			bridgeValue,
			from: from.compactMap { graph.node(for: $0) },
			to: to.compactMap { graph.node(for: $0) },
			mutually: true
		)
	}
}
