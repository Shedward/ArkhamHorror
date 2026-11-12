//
//  Data.swift
//  
//
//  Created by Vladislav Maltsev on 08.03.2022.
//

public protocol DataParser {
	associatedtype Data
	associatedtype Context

	func parse(head: String, parametersReader: ExpressionParameterReader<Context>) throws -> Data
}
