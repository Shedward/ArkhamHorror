//
//  DebugGraphFormatter.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public struct DebugGraphFormatter<T> {
	private let formatValue: (T) -> String

	public init(_ formatValue: @escaping (T) -> String = String.init(describing:)) {
		self.formatValue = formatValue
	}

	public func format(from graph: Graph<T>) -> String {
		let nodeDescriptions = graph.allNodes.map(format(from:)).joined(separator: "\n")
		let indentedNodes = addIdentation("  ", to: nodeDescriptions)
		return "Graph<\(String(describing: T.self))>\n\(indentedNodes)"
	}

	public func format(from node: Node<T>) -> String {
		let neighborDescriptions = node.neighbors.map(formatValue(node:)).joined(separator: "\n")
		let indentedNeighborDescription = addIdentation("  -> ", to: neighborDescriptions)
		return "\(formatValue(node: node))\n\(indentedNeighborDescription)"
	}

	public func formatValue(node: Node<T>) -> String {
		formatValue(node.value)
	}

	private func addIdentation(_ identation: String, to string: String) -> String {
		string
			.split(separator: "\n")
			.map { identation + $0 }
			.joined(separator: "\n")
	}
}
