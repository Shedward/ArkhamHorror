//
//  Node.swift
//  
//
//  Created by Vladislav Maltsev on 01.01.2022.
//

public class Node<T>: Equatable {
	public var value: T
	public private(set) weak var graph: Graph<T>?
	public private(set) var neighbors: [Node<T>] = []

	internal init(value: T, graph: Graph<T>) {
		self.value = value
		self.graph = graph
	}

	public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
		lhs === rhs
	}

	public func connect(to anotherNode: Node<T>) {
		guard !neighbors.contains(anotherNode) else {
			// Node \(self) is already connected to \(anotherNode)
			return
		}
		guard self != anotherNode else {
			assertionFailure("Can not connect node \(self) to itself")
			return
		}
		guard graph === anotherNode.graph else {
			assertionFailure(
				"""
				Node \(self) can not be connected to \(anotherNode), \
				since it not in the same graph \(String(describing: anotherNode.graph))
				"""
			)
			return
		}

		neighbors.append(anotherNode)
	}

	public func disconnect(from anotherNode: Node<T>) {
		neighbors.removeAll { $0 == anotherNode }
	}

	public func connectMutually(to anotherNode: Node<T>) {
		connect(to: anotherNode)
		anotherNode.connect(to: self)
	}

	public func isNeighbor(to another: Node<T>) -> Bool {
		neighbors.contains(another)
	}
}

extension Node where T: Equatable {
	func neighbor(for value: T) -> Node<T>? {
		neighbors.first { $0.value == value }
	}
}

@available(macOS 10.15, *)
extension Node where T: Identifiable {
	public func node(for identifier: T.ID) -> Node<T>? {
		neighbors.first { $0.value.id == identifier }
	}
}
