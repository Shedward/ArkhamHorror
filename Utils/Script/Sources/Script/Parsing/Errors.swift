//
//  Errors.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

struct SyntaxError: Error {
	let message: String
	let position: String.Index
}

struct SemanticError: Error {
	let message: String
	let position: String.Index
}

struct TypeError: Error {
	let message: String
}
