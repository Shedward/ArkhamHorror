//
//  MockDependencies.swift
//  Arkham Horror
//
//  Created by Vladislav Maltsev on 19.11.2022.
//

import ArkhamHorror
import DesignSystem

struct MockDependencies: AllDependencies {
    var campaignLoader: CampaignLoader
    var animationQueue: AnimationQueue

    init() {
        self.campaignLoader = InMemoryCampaignLoader()
        self.animationQueue = AnimationQueue()
    }
}
