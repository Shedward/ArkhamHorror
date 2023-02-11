//
//  DataSource.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

public protocol CollectionDataSource {
    associatedtype Model

    func count() -> Int
    func model(at index: Int) -> Model
}
