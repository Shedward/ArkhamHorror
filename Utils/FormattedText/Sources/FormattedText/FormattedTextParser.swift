//
//  FormattedTextParser.swift
//  
//
//  Created by Vladislav Maltsev on 25.02.2022.
//

public struct FormattedTextParser {
	public init() {
	}

	public func parse(_ string: String) throws -> FormattedText {
		FormattedText(from: string)
	}
}
