//
//  Logger.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public struct Logger {
    static var impl: LoggerImplementation = PrintLoggerImplementation(minLevel: .info)

    public enum Level: Int {
        case info
        case warning
        case error
        case debug
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

    @available(*, deprecated, message: "Debug logs should be removed before commit")
    public func debug(_ message: @autoclosure () -> String) {
        Self.impl.log(label: label, level: .debug, message: message)
    }

    @available(*, deprecated, message: "Debug logs should be removed before commit")
    public func track(_ message: @autoclosure () -> String, function: StaticString = #function) {
        let message = { "- \(function): \(message())" }
        Self.impl.log(label: label, level: .debug, message: message)
    }
}

public protocol LoggerImplementation {
    func log(label: StaticString, level: Logger.Level, message: () -> String)
}

public struct PrintLoggerImplementation: LoggerImplementation {
    public var minLevel: Logger.Level

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
        case .debug:
            return "[Debug]"
        case .info:
            return "[Info]"
        case .warning:
            return "[Warn]"
        case .error:
            return "[Error]"
        }
    }
}
