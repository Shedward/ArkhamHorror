//
//  CampaignLoadingTests.swift
//  
//
//  Created by Vladislav Maltsev on 06.02.2023.
//

import ArkhamHorror
import Game
import Foundation
import XCTest

final class CampaignLoadingTests: XCTestCase {
    func testLoadingCampaignsInfo() async throws {
        let rootUrl = try XCTUnwrap(Resources.campaignDirectory)
        let directoryStorage = DirectoryCampaignLoader(rootPath: rootUrl)
        let campaigns = try await directoryStorage.campaignsInfo()
        XCTAssertGreaterThan(campaigns.count, 0)
    }

    func testLoadingCampaign() async throws {
        let rootUrl = try XCTUnwrap(Resources.campaignDirectory)
        let directoryStorage = DirectoryCampaignLoader(rootPath: rootUrl)
        let campaign = try await directoryStorage.loadCampaign(id: "industrial_demo")
        XCTAssertEqual(campaign.id, "industrial_demo")
        XCTAssertGreaterThan(campaign.availableCharacters.count, 0)
    }
}
