//
//  Debug.swift
//  
//
//  Created by Vladislav Maltsev on 05.03.2023.
//

import Dispatch
import Foundation

@available(*, deprecated, message: "Debug only")
public func delayToMain(_ time: TimeInterval, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(time * 1000)), execute: action)
}

@available(*, deprecated, message: "Not implemented")
public func notImplemented() -> Never {
    fatalError("Not implemented")
}
