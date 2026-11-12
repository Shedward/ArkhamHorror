//
//  AnyExpressions.swift
//  
//
//  Created by Vladislav Maltsev on 23.02.2022.
//

public typealias AnyPredicate<Context> = AnyExpression<Context, Bool>

public typealias AnyAction<Context> = AnyExpression<Context, Void>
