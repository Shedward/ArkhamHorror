//
//  AnyCollectionCellProvider.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public struct AnyCollectionCellProvider<Cell: View, Model>: CollectionCellProvider {
    private let cellForModel: (Model) -> Cell

    init<Wrapped: CollectionCellProvider>(
        _ wrapped: Wrapped
    ) where Wrapped.Cell == Cell, Wrapped.Model == Model {
        self.cellForModel = wrapped.cell(for:)
    }

    public func cell(for model: Model) -> Cell {
        cellForModel(model)
    }
}

extension CollectionCellProvider {
    public func asAny() -> AnyCollectionCellProvider<Cell, Model> {
        AnyCollectionCellProvider(self)
    }
}
