//
//  Dependencies.swift
//  
//
//  Created by Vladislav Maltsev on 09.02.2023.
//

import ArkhamHorror
import DesignSystem

enum DependenciesError: Error {
    case campaignDirectoryNotFound
}

struct Dependencies: AllDependencies {
    var campaignLoader: CampaignLoader
    var animationQueue: AnimationQueue

    init() throws {
        guard let campaignsRootPath = Resources.campaignDirectory else {
            throw DependenciesError.campaignDirectoryNotFound
        }
        self.campaignLoader = DirectoryCampaignLoader(rootPath: campaignsRootPath)
        self.animationQueue = AnimationQueue()
    }
}
