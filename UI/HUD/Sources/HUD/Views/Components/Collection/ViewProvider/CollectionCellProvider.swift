//
//  CollectionCellProvider.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public protocol CollectionCellProvider {
    associatedtype Cell: View
    associatedtype Model

    func cell(for model: Model) -> Cell
}
