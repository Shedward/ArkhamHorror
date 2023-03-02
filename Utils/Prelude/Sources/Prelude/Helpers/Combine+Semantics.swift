//
//  Combine+Semantics.swift
//  
//
//  Created by Vladislav Maltsev on 28.02.2023.
//

import Combine

public typealias EventSubject<Output> = PassthroughSubject<Output, Never>
public typealias EventPublisher<Output> = AnyPublisher<Output, Never>

public typealias ValueSubject<Value> = CurrentValueSubject<Value, Never>
public typealias ValuePublisher<Value> = AnyPublisher<Value, Never>

public typealias Subscriptions = [AnyCancellable]
