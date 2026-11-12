//
//  Deck.swift
//
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

public struct Deck<Card> {
	internal var cards: [Card]

	public var count: Int {
		cards.count
	}

	public var isEmpty: Bool {
		cards.isEmpty
	}

	public init() {
		self.cards = []
	}

	public init(cards: [Card]) {
		self.cards = cards
	}

	public init(copy another: Deck<Card>) {
		self.cards = another.cards
	}
}

extension Deck: Equatable where Card: Equatable {
	public static func == (_ lhs: Self, _ rhs: Self) -> Bool {
		lhs.cards == rhs.cards
	}
}
