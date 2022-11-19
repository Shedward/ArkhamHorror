//
//  MockDependencies.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 19.11.2022.
//

import ArkhamHorror

struct MockDependencies: AllDependencies {
    var campaignStorage: CampaignStorage

    init() {
        self.campaignStorage = MockCampaignStorage()
    }
}
