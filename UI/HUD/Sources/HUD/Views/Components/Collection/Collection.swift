//
//  Collection.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import Prelude

public class Collection<
    DataSource: CollectionDataSource,
    CellProdiver: CollectionCellProvider
>: View
    where DataSource.Model == CellProdiver.Model
{
    typealias Model = DataSource.Model
    typealias Cell = CellProdiver.Cell
    typealias Index = Int

    public var node: SKNode

    private let dataSource: DataSource
    private var layout: CollectionLayout
    private let cellProvider: CellProdiver

    private var cells: [Index: Cell] = [:]
    private let size: CGSize
    private let logger = Logger()

    public init(
        size: CGSize,
        dataSource: DataSource,
        layout: CollectionLayout,
        cellProvider: CellProdiver
    ) {
        self.size = size
        self.dataSource = dataSource
        self.layout = layout
        self.cellProvider = cellProvider
        self.node = SKNode()

        reloadCells(at: allIndices())
        layoutCells(at: allIndices())
    }

    private func reloadCells(at indices: [Index]) {
        indices.forEach { index in
            let model = dataSource.model(at: index)
            let cell = cellProvider.cell(for: model)
            if let oldCell = cells[index] {
                dismissCell(oldCell)
            }
            presentCell(cell)
            cells[index] = cell
        }
    }

    private func layoutCells(at indices: [Index]) {
        let context = CollectionLayoutContext(
            containerSize: size,
            contentSize: layout.contentSize(for: dataSource)
        )
        indices.forEach { index in
            let layout = layout.cellLayout(at: index, context: context)
            if let node = cells[index]?.node {
                node.position = layout.position
            } else {
                logger.warning("""
                Tried to layout cell at \(index) \
                which is not loaded in Collection \(self)
                """)
            }
        }
    }

    private func allIndices() -> [Index] {
        Array(0..<dataSource.count())
    }

    private func presentCell(_ cell: Cell) {
        node.addChild(cell.node)
    }

    private func dismissCell(_ cell: Cell) {
        cell.node.removeFromParent()
    }
}
