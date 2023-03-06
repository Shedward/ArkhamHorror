//
//  ColorTests.swift
//  
//
//  Created by Vladislav Maltsev on 06.03.2023.
//

import XCTest
import ArkhamHorror

final class ColorTests: XCTestCase {
    func testGrayscale() throws {
        let color = try Color(red: 0xAA, green: 0xAA, blue: 0xAA)
        let string = color.toString()
        XCTAssertEqual(string, "#aa")
        let parsedColor = try Color(string: string)
        XCTAssertEqual(color, parsedColor)
    }

    func testGrayscaleWithAlpha() throws {
        let color = try Color(red: 0xAA, green: 0xAA, blue: 0xAA, alpha: 0x10)
        let string = color.toString()
        XCTAssertEqual(string, "#aa10")
        let parsedColor = try Color(string: string)
        XCTAssertEqual(color, parsedColor)
    }

    func testNonGrayscale() throws {
        let color = try Color(red: 0xAA, green: 0xAB, blue: 0xAA)
        let string = color.toString()
        XCTAssertEqual(string, "#aaabaa")
        let parsedColor = try Color(string: string)
        XCTAssertEqual(color, parsedColor)
    }

    func testNonGrayscaleWithAlpha() throws {
        let color = try Color(red: 0xAA, green: 0xAB, blue: 0xAA, alpha: 0x10)
        let string = color.toString()
        XCTAssertEqual(string, "#aaabaa10")
        let parsedColor = try Color(string: string)
        XCTAssertEqual(color, parsedColor)
    }

    func testTooBigValues() throws {
        XCTAssertThrowsError(try Color(red: 0xFFF, green: 0xAB, blue: 0xAA, alpha: 0x10))
    }

    func testWrongString() throws {
        XCTAssertThrowsError(try Color(string: "failed"))
        XCTAssertThrowsError(try Color(string: "#1234567"))
        XCTAssertThrowsError(try Color(string: ""))
    }
}
