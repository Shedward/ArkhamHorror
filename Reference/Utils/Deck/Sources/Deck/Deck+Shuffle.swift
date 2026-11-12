//
//  Deck+Shuffle.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

extension Deck {
	public mutating func shuffle() {
		shuffle(strategy: Shuffles.Random())
	}

	public mutating func shuffle<S: ShuffleStrategy>(strategy: S) where S.Item == Card {
		let newCards = strategy.shuffle(cards)
		assert(newCards.count == cards.count, "ShuffleStrategy should not change count of cards")
		cards = newCards
	}
}
