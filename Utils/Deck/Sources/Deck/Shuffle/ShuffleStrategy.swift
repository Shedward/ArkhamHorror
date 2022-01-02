//
//  ShuffleStrategy.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public protocol ShuffleStrategy {
	associatedtype Item
	func shuffle(_ items: [Item]) -> [Item]
}

public enum Shuffles { }
