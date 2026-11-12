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

public protocol Withable {
    func with(_ configure: (inout Self) -> Void) -> Self
}

public extension Withable {
    func with(_ configure: (inout Self) -> Void) -> Self {
        Prelude.with(self, configure)
    }
}

public extension Withable where Self: Initable {
    static func with(_ configure: (inout Self) -> Void) -> Self {
        Prelude.with(Self.init(), configure)
    }
}
