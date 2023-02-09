//
//  Dependencies.swift
//  
//
//  Created by Vladislav Maltsev on 09.02.2023.
//

import ArkhamHorror

enum DependenciesError: Error {
    case campaignDirectoryNotFound
}

struct Dependencies: AllDependencies {
    var campaignStorage: CampaignLoader

    init() throws {
        guard let campaignsRootPath = Resources.campaignDirectory else {
            throw DependenciesError.campaignDirectoryNotFound
        }
        self.campaignStorage = DirectoryCampaignLoader(rootPath: campaignsRootPath)
    }
}