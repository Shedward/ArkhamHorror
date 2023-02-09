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
import XCTestUtils

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
        let campaign = try await directoryStorage.loadCampaign(id: "the_comming_of_azotot")
        XCTAssertEqual(campaign.id, "the_comming_of_azotot")
        XCTAssertGreaterThan(campaign.availableCharacters.count, 0)
    }
}
