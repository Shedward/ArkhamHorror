//
//  Errors.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

import Foundation

private extension Error {
    func underlyingDescription() -> String {
        if let localizedError = self as? LocalizedError {
            return localizedError.errorDescription ?? localizedError.localizedDescription
        } else {
            return String(describing: self)
        }
    }
}

public struct ParsingContext: CustomDebugStringConvertible {
    public let line: String
    public let lineIndex: Int
    public let colIndex: Int

    public init(from string: String, position: String.Index) {
        var lineIndex: Int = 1
        var colIndex: Int = 0
        var line: String = ""

        var startOfCurrentLine: String.Index = string.startIndex

        while startOfCurrentLine != string.endIndex {
            let lineRange = string.lineRange(for: startOfCurrentLine..<startOfCurrentLine)

            if lineRange.contains(position) {
                colIndex = string.distance(from: lineRange.lowerBound, to: position)

                var lineSubstring = string[lineRange]
                if lineSubstring.hasSuffix("\n") {
                    lineSubstring = lineSubstring.dropLast()
                }
                line = String(lineSubstring)
                break

            } else {
                startOfCurrentLine = lineRange.upperBound
                lineIndex += 1
            }
        }

        self.lineIndex = lineIndex
        self.colIndex = colIndex
        self.line = line
    }

    public var debugDescription: String {
        """
        ParsingContext at \(positionDescription)
        \(lineDescription)
        """
    }

    public var positionDescription: String {
        "\(lineIndex):\(colIndex)"
    }

    public var lineDescription: String {
        """
        \(line)
        \(String(repeating: " ", count: colIndex))↑
        """
    }
}

public struct SyntaxError: LocalizedError {
	public let message: String
	public let context: ParsingContext

    public init(message: String, context: ParsingContext) {
		self.message = message
		self.context = context
	}

	public var errorDescription: String? {
        """
        Syntax error at \(context.positionDescription)
        \(context.lineDescription)
        \(message)
        """
	}
}

public struct SemanticError: LocalizedError {
	public let message: String
	public let context: ParsingContext

	public init(message: String, context: ParsingContext) {
		self.message = message
		self.context = context
	}

    public var errorDescription: String? {
        """
        Semantic error at \(context.positionDescription)
        \(context.lineDescription)
        \(message)
        """
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
        """
        ExpressionError: Could not parse expression '\(expressionHead)':
        \(underlyingError.underlyingDescription())
        """
	}

    private func indentString(_ string: String, with indentation: String) -> String {
        string
            .split(separator: "\n")
            .map { "\(indentation)\($0)" }
            .joined(separator: "\n")
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

public struct ParameterError: LocalizedError {
	public let message: String
    public let underlyingError: Error

    public init(message: String, underlyingError: Error) {
		self.message = message
        self.underlyingError = underlyingError
	}

	public var errorDescription: String? {
		"""
        ParameterError: \(message)
        \(underlyingError.underlyingDescription())
        """
	}
}
