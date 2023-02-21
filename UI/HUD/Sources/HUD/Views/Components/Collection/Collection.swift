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

    public var dataSource: AnyCollectionDataSource<Model> {
        didSet { reloadAll() }
    }
    public var layout: CollectionLayout {
        didSet { reloadAll() }
    }
    public var cellProvider: AnyCollectionCellProvider<Cell, Model> {
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
        super.init()
    }

    public convenience init(
        size: CGSize,
        of cellType: Cell.Type,
        layout: CollectionLayout,
        dataSource: AnyCollectionDataSource<Model> = ArrayCollectionDataSource(data: []).asAny()
    ) where Cell: CollectionCell, Cell.Data == Model {
        self.init(
            size: size,
            layout: layout,
            cellProvider: ProtocolCollectionCellProvider<Cell>().asAny()
        )
    }

    private func reloadAll() {
        reloadCells(at: allIndices())
        layout()
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
        addChild(cell)
    }

    private func dismissCell(_ cell: Cell) {
        cell.removeFromSuperview()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        layoutCells(at: allIndices())
    }
}
