//
//  SReader.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public struct SReader<Context> {
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
