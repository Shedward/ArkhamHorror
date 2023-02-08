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

    func testParsing() async throws {
        let modelString = "link: //res/test"

        let decoder = YAMLDecoder()
        let model = try decoder.decode(
            TestModel.self,
            from: modelString,
            userInfo: [ResourceLink.CodingUserInfoKey.resourceLoader: resourceLoader()]
        )

        XCTAssertEqual(model.link.path, "res/test")
        let data = try await model.link.load()
        XCTAssertTrue(data.isEmpty)

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
        let modelString = "link: wrong/resource/link"

        let decoder = YAMLDecoder()
        XCTAssertThrowsError(try decoder.decode(
            TestModel.self,
            from: modelString,
            userInfo: [ResourceLink.CodingUserInfoKey.resourceLoader: resourceLoader()]
        ))
    }

    private func resourceLoader() -> ResourceLoader {
        let resourceLoader = InMemoryResourceLoader()
        resourceLoader.addResource(Data(), to: "res/test")
        return resourceLoader
    }
}
