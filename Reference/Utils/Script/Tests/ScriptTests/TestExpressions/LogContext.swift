//
//  LogContext.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

final class LogContext {
	var logs: [String] = []

	func log(_ message: String) {
		logs.append(message)
	}
}
