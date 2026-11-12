//
//  ProtocolCollectionCellProvider.swift
//  
//
//  Created by Vladislav Maltsev on 21.02.2023.
//

public protocol CollectionCell: View {
    associatedtype Data
    init(data: Data)
}

public struct ProtocolCollectionCellProvider<Cell: CollectionCell>: CollectionCellProvider {
    public typealias Cell = Cell
    public typealias Model = Cell.Data

    public init() {
    }

    public func cell(for model: Model) -> Cell {
        Cell(data: model)
    }
}
