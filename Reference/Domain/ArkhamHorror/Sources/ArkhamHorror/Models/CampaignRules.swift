//
//  CampaignRules.swift
//  
//
//  Created by Vladislav Maltsev on 08.02.2023.
//

import Foundation
import Common

public struct CampaignRules: Codable {
    let initialPosition: Region.ID
    let defaultCountOfActions: Int
}
