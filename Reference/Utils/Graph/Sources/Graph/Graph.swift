//
//  Graph.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public class Graph<T> {
	internal private(set) var allNodes: [Node<T>] = []

	public init() {
	}

	public func createNode(_ value: T) -> Node<T> {
		let node = Node(value: value, graph: self)
		allNodes.append(node)
		return node
	}

	public func deleteNode(_ node: Node<T>) {
		allNodes.removeAll { $0 === node }
		allNodes.forEach { $0.disconnect(from: node) }
	}
}

extension Graph where T: Equatable {
	public func node(for value: T) -> Node<T>? {
		allNodes.first { $0.value == value }
	}
}

@available(macOS 10.15, iOS 13.0, *)
extension Graph where T: Identifiable {
	public func node(for identifier: T.ID) -> Node<T>? {
		allNodes.first { $0.value.id == identifier }
	}
}
