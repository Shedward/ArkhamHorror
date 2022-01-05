//
//  XCTestUtils.swift
//
//
//  Created by Vladislav Maltsev on 05.01.2022.
//

import XCTest

public func XCTAssertEqualDescription<T>(
	_ t: T,
	_ description: String,
	file: StaticString = #filePath,
	line: UInt = #line
) {
	XCTAssertEqual(String(describing: t), description, file: file, line: line)
}


