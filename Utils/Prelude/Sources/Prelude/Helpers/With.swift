//
//  With.swift
//  
//
//  Created by Vladislav Maltsev on 19.08.2022.
//

import Foundation

public func with<T>(_ value: T, _ configure: (inout T) -> Void) -> T {
    var value = value
    configure(&value)
    return value
}

