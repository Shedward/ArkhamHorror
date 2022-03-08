//
//  CostTest.swift
//  
//
//  Created by Vladislav Maltsev on 07.03.2022.
//

public struct CostTest {
	private let testAction: (Int) -> Bool

	public init(_ testAction: @escaping (Int) -> Bool) {
		self.testAction = testAction
	}

	public func test(_ value: Int) -> Bool {
		testAction(value)
	}
}
