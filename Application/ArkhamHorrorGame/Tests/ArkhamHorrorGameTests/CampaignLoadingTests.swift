//
//  CampaignLoadingTests.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import ArkhamHorror
import ArkhamHorrorGame
import Foundation
import XCTest

final class CampaignLoadingTests: XCTestCase {
    func testLoading() async throws {
        let bundle = Resources.bundle
        let campaignFolder = try XCTUnwrap(bundle.resourcePath?.appending("/Campaigns"))
        let rootUrl = try XCTUnwrap(URL(filePath: campaignFolder))
        let directoryStorage = DirectoryCampaignLoader(rootPath: rootUrl)
        let campaigns = try await directoryStorage.campaigns()
        XCTAssertGreaterThan(campaigns.count, 0)
    }
}
