//
//  Collection.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import SpriteKit
import Prelude

public class Collection<Model, Cell: View>: View {
    typealias Index = Int

    public var node: SKNode = .init()

    var dataSource: AnyCollectionDataSource<Model> {
        didSet { reloadAll() }
    }
    var layout: CollectionLayout {
        didSet { reloadAll() }
    }
    var cellProvider: AnyCollectionCellProvider<Cell, Model> {
        didSet { reloadAll() }
    }

    private var cells: [Index: Cell] = [:]
    private let size: CGSize
    private let logger = Logger()

    public init(
        size: CGSize,
        dataSource: AnyCollectionDataSource<Model> = ArrayCollectionDataSource(data: []).asAny(),
        layout: CollectionLayout,
        cellProvider: AnyCollectionCellProvider<Cell, Model>
    ) {
        self.size = size
        self.dataSource = AnyCollectionDataSource(dataSource)
        self.layout = layout
        self.cellProvider = AnyCollectionCellProvider(cellProvider)
    }

    private func reloadAll() {
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