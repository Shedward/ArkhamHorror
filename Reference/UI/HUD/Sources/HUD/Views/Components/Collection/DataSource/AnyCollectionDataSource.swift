//
//  AnyCollectionDataSource.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Foundation

public struct AnyCollectionDataSource<Model>: CollectionDataSource {
    private let wrapped: any CollectionDataSource

    public init<Wrapped: CollectionDataSource>(
        _ wrapped: Wrapped
    ) where Wrapped.Model == Model {
        self.wrapped = wrapped
    }

    public func count() -> Int {
        wrapped.count()
    }

    public func model(at index: Int) -> Model {
        wrapped.model(at: index) as! Model
    }
}

extension CollectionDataSource {
    public func asAny() -> AnyCollectionDataSource<Model> {
        AnyCollectionDataSource(self)
    }
}
