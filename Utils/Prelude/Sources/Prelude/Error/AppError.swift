//
//  DescriptiveError.swift
//  
//
//  Created by Vladislav Maltsev on 09.02.2023.
//

import Foundation

public protocol AppError: Error, LocalizedError {
}

extension AppError {
    public var localizedDescription: String {
        String(describing: self)
    }
}
