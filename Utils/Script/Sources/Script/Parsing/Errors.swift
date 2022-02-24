//
//  Errors.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Foundation

struct SyntaxError: LocalizedError {
	let message: String
	let position: String.Index

	var errorDescription: String? {
		"SyntaxError at \(position): \(message)"
	}
}

struct SemanticError: LocalizedError {
	let message: String
	let position: String.Index

	var errorDescription: String? {
		"SemanticError at \(position): \(message)"
	}
}

struct TypeError: LocalizedError {
	let message: String

	var errorDescription: String? {
		"TypeError: \(message)"
	}
}
