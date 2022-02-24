//
//  ScriptTests.swift
//  
//
//  Created by Vladislav Maltsev on 24.02.2022.
//

import XCTest
import Script

final class ScriptTests: XCTestCase {
	private let printScriptParser: ScriptParser<LogContext, Void> = {
		var scriptParser = ScriptParser<LogContext, Void>()
		try! scriptParser.register(IfParser<LogContext, Void>())
		try! scriptParser.register(DoParser())
		try! scriptParser.register(DoNothingParser())
		try! scriptParser.register(PrintParser())
		try! scriptParser.register(CheckLogLengthParser())
		try! scriptParser.register(ConcatParser())
		return scriptParser
	}()

	func testBaseScript() async throws {
		let output = try await runScript("""
			(print "Hello world")
			""")

		XCTAssertEqual(
			output,
			[
				"Hello world"
			]
		)
	}

	func testMoreComplexScript() async throws {
		let output = try await runScript("""
			(do
				(print "First line")
				(print "Second line")
				(if (checkLogLength 2)
					(print "Too long")
					(print "Less than 2 lines")
				)
			)
			""")

		XCTAssertEqual(
			output,
			[
				"First line",
				"Second line",
				"Too long"
			]
		)
	}

	private func runScript(_ script: String) async throws -> [String] {
		let script = try printScriptParser.parse(string: script)

		let context = LogContext()
		await script.run(in: context)
		return context.logs
	}
}
