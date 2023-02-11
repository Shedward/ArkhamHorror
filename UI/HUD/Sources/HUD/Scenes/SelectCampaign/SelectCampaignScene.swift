//
//  SelectCampaignScene.swift
//  
//
//  Created by Vladislav Maltsev on 10.02.2023.
//

import SpriteKit
import Prelude
import ArkhamHorror

final class SelectCampaignScene: Scene<SelectCampaignViewModel>, SelectCampaignSceneProtocol {

    private var collection: Collection<CampaignCell.Data, CampaignCell>?

    override func setup() {
        super.setup()

        let cellSize = CGSize(width: 128 + 64, height: 256)
        let cellProvider = FnCollectionCellProvider(createCell: CampaignCell.init)
        let collection = Collection(
            size: size,
            layout: CenteredRowLayout(itemSize: cellSize, spacing: 64),
            cellProvider: cellProvider.asAny()
        )
        addChild(collection.node)
        self.collection = collection
    }

    func displayCampaigns(_ loading: Loading<[CampaignCell.Data]>) {
        let campaigns = loading.value ?? []
        collection?.dataSource = ArrayCollectionDataSource(data: campaigns).asAny()
    }
}
