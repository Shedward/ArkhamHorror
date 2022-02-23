//
//  TokenReader.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Foundation

struct TokenReader {
	private let scanner: Scanner

	var currentIndex: String.Index {
		get { scanner.currentIndex }
		set { scanner.currentIndex = newValue }
	}

	init(string: String) {
		scanner = .init(string: string)
		scanner.charactersToBeSkipped = nil
	}

	func readInt() throws -> Int {
		try readOrReturnBack { scanner in
			guard let value = scanner.scanInt() else {
				throw SyntaxError(message: "Expected Int", position: scanner.currentIndex)
			}
			return value
		}
	}

	func readSymbol() throws -> String {
		try readOrReturnBack { scanner in
			let symbol = scanner.scanCharacters(from: .alphanumerics)
			guard let symbol = symbol, !symbol.isEmpty else {
				throw SyntaxError(message: "Expected symbol", position: scanner.currentIndex)
			}
			return symbol
		}
	}

	func readString() throws -> String {
		try readOrReturnBack { scanner in
			guard scanner.scanString("\"") != nil else {
				throw SyntaxError(message: "Expected string", position: scanner.currentIndex)
			}
			guard let string = scanner.scanUpToString("\"") else {
				throw SyntaxError(message: "Expected string", position: scanner.currentIndex)
			}

			let _ = scanner.scanString("\"")
			return string
		}
	}

	func skipSeparator() throws {
		try readOrReturnBack { scanner in
			let separator = scanner.scanCharacters(from: .whitespacesAndNewlines)

			if separator?.isEmpty ?? true {
				throw SyntaxError(message: "Expected separator", position: scanner.currentIndex)
			}
		}
	}

	func openExpression() throws {
		try readOrReturnBack { scanner in
			guard scanner.scanString("(") != nil else {
				throw SyntaxError(message: "Expected '('", position: scanner.currentIndex)
			}
		}
	}

	func closeExpression() throws {
		try readOrReturnBack { scanner in
			guard scanner.scanString(")") != nil else {
				throw SyntaxError(message: "Expected ')'", position: scanner.currentIndex)
			}
		}
	}

	private func readOrReturnBack<T>(_ scanning: (Scanner) throws -> T) rethrows -> T {
		let initialPosition = scanner.currentIndex

		do {
			return try scanning(scanner)
		} catch {
			scanner.currentIndex = initialPosition
			throw error
		}
	}
}
