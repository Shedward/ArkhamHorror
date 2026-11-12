//
//  Deck+DrawAndPlace.swift
//  
//
//  Created by Vladislav Maltsev on 02.01.2022.
//

extension Deck {
	internal var top: Card? {
		cards.first
	}

	internal var bottom: Card? {
		cards.last
	}

	public mutating func drawTop() -> Card? {
		drawTop(count: 1).cards.first
	}

	public mutating func drawTop(count: Int) -> Deck<Card> {
		let topCards = Array(cards.prefix(count))
		cards = Array(cards.dropFirst(count))
		return Deck(cards: topCards)
	}

	public mutating func drawBottom() -> Card? {
		drawBottom(count: 1).cards.last
	}

	public mutating func drawBottom(count: Int) -> Deck<Card> {
		let topCards = Array(cards.suffix(count))
		cards = Array(cards.dropLast(count))
		return Deck(cards: topCards)
	}

	public mutating func placeOnTop(_ newCard: Card) {
		cards = [newCard] + cards
	}

	public mutating func placeOnTop(_ another: inout Deck<Card>) {
		cards = another.cards + cards
		another.cards.removeAll()
	}

	public mutating func placeOnBottom(_ newCard: Card) {
		cards = cards + [newCard]
	}

	public mutating func placeOnBottom(_ another: inout Deck<Card>) {
		cards = cards + another.cards
		another.cards.removeAll()
	}

	public mutating func split(by isLeft: (Card) -> Bool) -> (Deck<Card>, Deck<Card>) {
		var leftCards: [Card] = []
		var rightCards: [Card] = []

		cards.forEach { card in
			if isLeft(card) {
				leftCards.append(card)
			} else {
				rightCards.append(card)
			}
		}
		cards.removeAll()

		return (Deck(cards: leftCards), Deck(cards: rightCards))
	}
}
