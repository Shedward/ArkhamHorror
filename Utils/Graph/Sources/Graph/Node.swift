//
//  Node.swift
//  
//
//  Created by Vladislav Maltsev on 01.01.2022.
//

public enum NodeConnectionError: Error {
	case nodeCannotConnectToItself
	case nodesAlreadyConnected
	case nodesFromDifferentGraphs
}

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

	@discardableResult
	public func connect(to anotherNode: Node<T>) -> Result<Void, NodeConnectionError> {
		guard !neighbors.contains(anotherNode) else {
			return .failure(.nodesAlreadyConnected)
		}
		guard self != anotherNode else {
			return .failure(.nodeCannotConnectToItself)
		}
		guard graph === anotherNode.graph else {
			return .failure(.nodesFromDifferentGraphs)
		}

		neighbors.append(anotherNode)
		return .success(())
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
	public func neighbor(for value: T) -> Node<T>? {
		neighbors.first { $0.value == value }
	}
}

@available(macOS 10.15, *)
extension Node where T: Identifiable {
	public func neighbor(for identifier: T.ID) -> Node<T>? {
		neighbors.first { $0.value.id == identifier }
	}
}
