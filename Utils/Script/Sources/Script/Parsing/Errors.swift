//
//  Errors.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Foundation

public struct SyntaxError: LocalizedError {
	public let message: String
	public let position: String.Index

	public init(message: String, position: String.Index) {
		self.message = message
		self.position = position
	}

	public var errorDescription: String? {
		"SyntaxError at \(position): \(message)"
	}
}

public struct SemanticError: LocalizedError {
	public let message: String
	public let position: String.Index

	public init(message: String, position: String.Index) {
		self.message = message
		self.position = position
	}

	public var errorDescription: String? {
		"SemanticError at \(position): \(message)"
	}
}

public struct TypeError: LocalizedError {
	public let message: String
	public let recoverySuggestion: String?

	public var errorDescription: String? {
		"TypeError: \(message)"
	}

	public init(message: String, recoverySuggestion: String? = nil) {
		self.message = message
		self.recoverySuggestion = recoverySuggestion
	}
}

public struct ExpressionError: LocalizedError {
	public let expressionHead: String
	public let underlyingError: Error

	public init(expressionHead: String, underlyingError: Error) {
		self.expressionHead = expressionHead
		self.underlyingError = underlyingError
	}

	public var errorDescription: String? {
		"ExpressionError: Could not parse expression '\(expressionHead)':\n\(underlyingError.localizedDescription)"
	}
}

public struct DataError: LocalizedError {
	public let message: String

	public init(message: String) {
		self.message = message
	}

	public var errorDescription: String? {
		"DataError: \(message)"
	}
}
