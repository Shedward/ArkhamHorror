//
//  ResourceLinkTests.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import XCTest
import ArkhamHorror
import Yams

final class ResourceLinkTests: XCTestCase {
    struct TestModel: Codable, Equatable {
        let link: ResourceLink
    }

    func testParsing() throws {
        let modelString = "link: //some/resource/link"

        let decoder = YAMLDecoder()
        let model = try decoder.decode(
            TestModel.self,
            from: modelString,
            userInfo: [ResourceLink.CodingUserInfoKey.resourcePrefix: "campaigns/some_campaign"]
        )

        XCTAssertEqual(model.link.path, "some/resource/link")
        XCTAssertEqual(model.link.prefix, "campaigns/some_campaign")
        XCTAssertEqual(model.link.fullPath.absoluteString, "campaigns/some_campaign/some/resource/link")

        let encoder = YAMLEncoder()
        let string = try encoder.encode(model)
        XCTAssertEqual(string.trimmingCharacters(in: .whitespacesAndNewlines), modelString)
    }

    func testFailingWithoutContext() throws {
        let modelString = "link: //some/resource/link"

        let decoder = YAMLDecoder()
        XCTAssertThrowsError(try decoder.decode(
            TestModel.self,
            from: modelString
        ))
    }

    func testFailingWrongStartOfPath() throws {
        let modelString = "link: some/resource/link"

        let decoder = YAMLDecoder()
        XCTAssertThrowsError(try decoder.decode(
            TestModel.self,
            from: modelString,
            userInfo: [ResourceLink.CodingUserInfoKey.resourcePrefix: "campaigns/some_campaign"]
        ))
    }

    func testFailingInvalidPath() throws {
        let modelString = "link: //some wrong path"

        let decoder = YAMLDecoder()
        XCTAssertThrowsError(try decoder.decode(
            TestModel.self,
            from: modelString,
            userInfo: [ResourceLink.CodingUserInfoKey.resourcePrefix: "campaigns/some_campaign"]
        ))
    }

    func testFailingInvalidPrefix() throws {
        let modelString = "link: //some/resource/path"

        let decoder = YAMLDecoder()
        XCTAssertThrowsError(try decoder.decode(
            TestModel.self,
            from: modelString,
            userInfo: [ResourceLink.CodingUserInfoKey.resourcePrefix: "some wrong path"]
        ))
    }
}
