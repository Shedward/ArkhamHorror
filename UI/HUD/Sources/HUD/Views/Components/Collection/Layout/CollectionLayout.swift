//
//  CollectionViewLayout.swift
//  
//
//  Created by Vladislav Maltsev on 11.02.2023.
//

import Foundation

public struct CollectionCellLayout {
    public var isValid: Bool
    public var position: CGPoint

    private init(isValid: Bool, position: CGPoint) {
        self.isValid = isValid
        self.position = position
    }

    public init(position: CGPoint) {
        self.init(isValid: false, position: position)
    }

    static let invalid = CollectionCellLayout(isValid: false, position: .zero)
}

public struct CollectionLayoutContext {
    public let containerSize: CGSize
    public let contentSize: CGSize

    init(containerSize: CGSize, contentSize: CGSize) {
        self.containerSize = containerSize
        self.contentSize = contentSize
    }
}

public protocol CollectionLayout {
    func contentSize(for dataSource: any CollectionDataSource) -> CGSize
    func cellLayout(at index: Int, context: CollectionLayoutContext) -> CollectionCellLayout
}
