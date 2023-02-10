//
//  AppError.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import Foundation

public struct AppError: Error, CustomStringConvertible, LocalizedError {
    public let message: String
    public let underlyingError: Error?
    public let position: String

    public init(
        _ message: String,
        underlyingError: Error? = nil,
        fileID: StaticString = #fileID,
        line: UInt = #line
    ) {
        self.message = message
        self.underlyingError = underlyingError
        self.position = "\(fileID):\(line)"
    }

    public var bottomError: Error? {
        if let underlyingError, let stackError = underlyingError as? AppError {
            return stackError.bottomError
        } else {
            return underlyingError
        }
    }

    public var description: String {
        if let underlyingError, let stackError = underlyingError as? AppError {
            return """
            \(position):\(message)
            \(stackError.description)
            """
        } else {
            return """
            \(position):\(message)
            \(underlyingError.debugDescription)
            """
        }
    }

    public var errorDescription: String? {
        description
    }
}
