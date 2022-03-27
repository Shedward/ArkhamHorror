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

    var currentContext: ParsingContext {
        ParsingContext(from: scanner.string, position: scanner.currentIndex)
    }

	init(string: String) {
		scanner = .init(string: string)
		scanner.charactersToBeSkipped = nil
	}

	func readInt() throws -> Int {
		try readOrReturnBack { scanner in
			guard let value = scanner.scanInt() else {
				throw SyntaxError(message: "Expected Int.", context: currentContext)
			}
			return value
		}
	}

	func readSymbol() throws -> String {
		try readOrReturnBack { scanner in
			let symbol = scanner.scanCharacters(from: .alphanumerics)
			guard let symbol = symbol, !symbol.isEmpty else {
				throw SyntaxError(message: "Expected symbol.", context: currentContext)
			}
			return symbol
		}
	}

	func readString() throws -> String {
		try readOrReturnBack { scanner in
			guard scanner.scanString("\"") != nil else {
                throw SyntaxError(message: "Expected string.", context: currentContext)
			}
			guard let string = scanner.scanUpToString("\"") else {
				throw SyntaxError(message: "Expected string.", context: currentContext)
			}

			let _ = scanner.scanString("\"")
			return string
		}
	}

    func readPlaceholder() -> Bool  {
        readOrReturnBack { scanner in
            let placeholder = scanner.scanString("_")
            return placeholder != nil
        }
    }

	func skipSeparator() {
        readOrReturnBack { scanner in
			_ = scanner.scanCharacters(from: .whitespacesAndNewlines)
		}
	}

	func openExpression() throws {
		try readOrReturnBack { scanner in
			guard scanner.scanString("(") != nil else {
				throw SyntaxError(message: "Expected '('.", context: currentContext)
			}
		}
	}

	func closeExpression() throws {
		try readOrReturnBack { scanner in
			guard scanner.scanString(")") != nil else {
				throw SyntaxError(message: "Expected ')'.", context: currentContext)
			}
		}
	}

	func peekRest() -> String? {
		let position = scanner.currentIndex
		let string = scanner.scanCharacters(from: CharacterSet().inverted)
		scanner.currentIndex = position
		return string
	}

	func willCloseExpression() -> Bool {
		let currentIndex = scanner.currentIndex
		let closeBracket = scanner.scanString(")")
		scanner.currentIndex = currentIndex
		return closeBracket != nil
	}

	func safeRead<T>(_ read: (TokenReader) throws -> T) rethrows -> T {
		let initialPosition = scanner.currentIndex

		do {
			return try read(self)
		} catch {
			scanner.currentIndex = initialPosition
			throw error
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
