//
//  CampaignGameboardViewModel.swift
//  
//
//  Created by Vladislav Maltsev on 16.02.2023.
//

import SpriteKit
import ArkhamHorror

final class CampaignGameboardViewModel: SceneViewModel {
    private let campaign: Campaign
    private let output: CampaignGameboardOutput

    weak var scene: CampaignGameboardSceneProtocol?

    init(campaign: Campaign, output: CampaignGameboardOutput) {
        self.campaign = campaign
        self.output = output
    }

    func sceneDidLoad() {
        let data = CampaignGameboardScene.Data(
            characterPortraits: campaign.availableCharacters.map(\.portrait),
            onBack: { [output] in
                output.onBack()
            }
        )
        scene?.display(data)
    }
}
