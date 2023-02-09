//
//  WeakBox.swift
//  
//
//  Created by Vladislav Maltsev on 08.08.2022.
//

public final class WeakBox<T: AnyObject> {
    public weak var value: T?

    public init(_ initialValue: T? = nil) {
        self.value = initialValue
    }
}
