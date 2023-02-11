//
//  Logger.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public struct Logger {
    static var impl: LoggerImplementation = PrintLoggerImplementation(minLevel: .warning)

    public enum Level: Int {
        case info
        case warning
        case error
    }

    private let label: StaticString

    public init(label: StaticString = #fileID) {
        self.label = label
    }

    public func info(_ message: @autoclosure () -> String) {
        Self.impl.log(label: label, level: .info, message: message)
    }

    public func warning(_ message: @autoclosure () -> String) {
        Self.impl.log(label: label, level: .warning, message: message)
    }

    public func error(_ message: @autoclosure () -> String) {
        Self.impl.log(label: label, level: .error, message: message)
    }
}

public protocol LoggerImplementation {
    func log(label: StaticString, level: Logger.Level, message: () -> String)
}

public struct PrintLoggerImplementation: LoggerImplementation {
    private let minLevel: Logger.Level

    init(minLevel: Logger.Level) {
        self.minLevel = minLevel
    }

    public func log(label: StaticString, level: Logger.Level, message: () -> String) {
        if level.rawValue >= minLevel.rawValue {
            print("\(description(for: level)) \(label): \(message())")
        }
    }

    private func description(for level: Logger.Level) -> String {
        switch level {
        case .info:
            return "[Info]"
        case .warning:
            return "[Warn]"
        case .error:
            return "[Error]"
        }
    }
}
