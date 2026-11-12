//
//  FnCollectionCellProvider.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public struct FnCollectionCellProvider<Cell: View, Model>: CollectionCellProvider {
    private let createCell: (Model) -> Cell

    public init(createCell: @escaping (Model) -> Cell) {
        self.createCell = createCell
    }

    public func cell(for model: Model) -> Cell {
        createCell(model)
    }
}
