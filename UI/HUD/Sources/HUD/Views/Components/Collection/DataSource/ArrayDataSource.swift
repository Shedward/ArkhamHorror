//
//  ArrayDataSource.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Foundation

public struct ArrayDataSource<Model>: CollectionDataSource {
    private let data: [Model]

    public init(data: [Model]) {
        self.data = data
    }

    public func count() -> Int {
        data.count
    }

    public func model(at index: Int) -> Model {
        data[index]
    }
}

