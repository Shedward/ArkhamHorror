//
//  SReader.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Foundation

struct SScanError: Error {
	let message: String
	let position: String.Index
}

struct SScanner {
	private let scanner: Scanner

	init(string: String) {
		scanner = .init(string: string)
		scanner.charactersToBeSkipped = nil
	}

	func scanInt() throws -> Int {
		try scanWithFallback { scanner in
			guard let value = scanner.scanInt() else {
				throw SScanError(message: "Expected Int", position: scanner.currentIndex)
			}
			return value
		}
	}

	func scanSymbol() throws -> String {
		try scanWithFallback { scanner in
			let symbol = scanner.scanCharacters(from: .alphanumerics)
			guard let symbol = symbol, !symbol.isEmpty else {
				throw SScanError(message: "Expected symbol", position: scanner.currentIndex)
			}
			return symbol
		}
	}

	func scanString() throws -> String {
		try scanWithFallback { scanner in
			guard scanner.scanString("\"") != nil else {
				throw SScanError(message: "Expected string", position: scanner.currentIndex)
			}
			guard let string = scanner.scanUpToString("\"") else {
				throw SScanError(message: "Expected string", position: scanner.currentIndex)
			}

			let _ = scanner.scanString("\"")
			return string
		}
	}

	func skipSeparator() throws {
		try scanWithFallback { scanner in
			let separator = scanner.scanCharacters(from: .whitespacesAndNewlines)

			if separator?.isEmpty ?? true {
				throw SScanError(message: "Expected separator", position: scanner.currentIndex)
			}
		}
	}

	func openExpression() throws {
		try scanWithFallback { scanner in
			guard scanner.scanString("(") != nil else {
				throw SScanError(message: "Expected '('", position: scanner.currentIndex)
			}
		}
	}

	func closeExpression() throws {
		try scanWithFallback { scanner in
			guard scanner.scanString(")") != nil else {
				throw SScanError(message: "Expected ')'", position: scanner.currentIndex)
			}
		}
	}

	private func scanWithFallback<T>(_ scanning: (Scanner) throws -> T) rethrows -> T {
		let initialPosition = scanner.currentIndex

		do {
			return try scanning(scanner)
		} catch {
			scanner.currentIndex = initialPosition
			throw error
		}
	}
}

public struct SParameterScanner {
	private let scanner: SScanner

	init(_ scanner: SScanner) {
		self.scanner = scanner
	}
}

public class SReader<Context> {
	private let scanner: Scanner

	public init(string: String) {
		self.scanner = Scanner(string: string)
	}

	public func readInt() throws -> Int {
		fatalError()
	}
	public func readString() throws -> String {
		fatalError()
	}
	public func readSymbol() throws -> String {
		fatalError()
	}
	public func readExpression<Result>(_ result: Result.Type) throws -> AnyExpression<Context, Result> {
		fatalError()
	}
	public func readExpression() throws -> AnyExpression<Context, Void> {
		fatalError()
	}
	public func haveParameter() -> Bool {
		fatalError()
	}
}
