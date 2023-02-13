//
//  HUDScenes.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Foundation
import ArkhamHorror

public struct HUDScenes {
    public typealias Dependencies =
        CampaignLoaderDependency

    public let size: CGSize
    public let dependencies: Dependencies

    public init(size: CGSize, dependencies: Dependencies) {
        self.size = size
        self.dependencies = dependencies
    }
}
