//
//  Box.swift
//  
//
//  Created by Vladislav Maltsev on 19.11.2022.
//

public final class Box<T> {
    public var value: T

    public init(_ initialValue: T) {
        self.value = initialValue
    }
}
