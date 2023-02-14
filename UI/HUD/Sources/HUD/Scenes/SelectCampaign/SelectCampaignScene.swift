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
    private let errorAlert = ErrorAlert()

    override func setup() {
        super.setup()

        let cellProvider = FnCollectionCellProvider(createCell: CampaignCell.init)
        let collection = Collection(
            size: size,
            layout: CenteredRowLayout(itemSize: CampaignCell.size, spacing: 64),
            cellProvider: cellProvider.asAny()
        )
        addChildView(collection)
        self.collection = collection

        addChildView(errorAlert)
    }

    func displayCampaigns(_ loading: Loading<[CampaignCell.Data]>) {
        let campaigns = loading.value ?? []
        collection?.dataSource = ArrayCollectionDataSource(data: campaigns).asAny()
        errorAlert.display(loading)
        layoutIfNeeded()
    }
}
