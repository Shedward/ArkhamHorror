//
//  CenteredRowLayout.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Foundation
import Prelude

public class CenteredRowLayout: CollectionLayout {
    let itemSize: CGSize
    let spacing: CGFloat

    private var origin: CGPoint = .zero

    public init(itemSize: CGSize, spacing: CGFloat) {
        self.itemSize = itemSize
        self.spacing = spacing
    }

    public func contentSize(for dataSource: any CollectionDataSource) -> CGSize {
        let count = CGFloat(dataSource.count())
        let totalWidth = count * itemSize.width + (count - 1) * spacing

        let contentSize = CGSize(
            width: totalWidth,
            height: itemSize.height
        )
        origin = CGPoint(
            x: -0.5 * contentSize.width + 0.5 * itemSize.width,
            y: -0.5 * contentSize.height + 0.5 * itemSize.height
        )

        return contentSize
    }

    public func cellLayout(at index: Int, context: CollectionLayoutContext) -> CollectionCellLayout {
        var position = origin
        position.x += CGFloat(index) * (itemSize.width + spacing)
        return CollectionCellLayout(position: position)
    }
}
