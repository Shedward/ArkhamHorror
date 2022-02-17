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

public func XCTAssertNear<T>(
	_ lhs: T,
	_ rhs: T,
	maxDifference: T = 0.01,
	file: StaticString = #filePath,
	line: UInt = #line
) where T: SignedNumeric, T: ExpressibleByFloatLiteral, T: Comparable {
	let difference = abs(lhs - rhs)
	if difference > maxDifference {
		XCTFail("Values \(lhs) and \(rhs) different by \(difference) which is more than expected \(maxDifference)", file: file, line: line)
	}
}
