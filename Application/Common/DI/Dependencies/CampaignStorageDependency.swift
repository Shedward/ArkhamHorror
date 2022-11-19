//
//  CampaignStorageDependency.swift
//  Arkham Horror (macOS)
//
//  Created by Vladislav Maltsev on 19.11.2022.
//

import ArkhamHorror

protocol CampaignStorageDependency {
    var campaignStorage: CampaignStorage { get set }
}
