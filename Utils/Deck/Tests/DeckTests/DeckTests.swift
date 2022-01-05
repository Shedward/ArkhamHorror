import XCTest
@testable import Deck

final class DeckTests: XCTestCase {
    func testTakingAndAppending() throws {
		let cards = [1, 2, 3, 4, 5]
		var deck = Deck(cards: cards)

		XCTAssertEqual(deck.count, cards.count)
		XCTAssertEqual(deck.cards, cards)

		let topCard = try XCTUnwrap(deck.drawTop())
		XCTAssertEqual(topCard, 1)
		XCTAssertEqual(deck.cards, [2, 3, 4, 5])

		let bottomCard = try XCTUnwrap(deck.drawBottom())
		XCTAssertEqual(bottomCard, 5)
		XCTAssertEqual(deck.cards, [2, 3, 4])

		deck.placeOnBottom(topCard)
		XCTAssertEqual(deck.bottom, topCard)
		XCTAssertEqual(deck.cards, [2, 3, 4, 1])

		deck.placeOnTop(bottomCard)
		XCTAssertEqual(deck.top, bottomCard)
		XCTAssertEqual(deck.cards, [5, 2, 3, 4, 1])

		var top3 = deck.drawTop(count: 3)
		XCTAssertEqual(top3.cards, [5, 2, 3])
		XCTAssertEqual(deck.cards, [4, 1])

		deck.placeOnTop(&top3)
		XCTAssertTrue(top3.isEmpty)

		var bottom3 = deck.drawBottom(count: 3)
		XCTAssertEqual(bottom3.cards, [3, 4, 1])
		XCTAssertEqual(deck.cards, [5, 2])

		deck.placeOnBottom(&bottom3)
		XCTAssertTrue(bottom3.isEmpty)
    }

	func testMergingAndSpliting() {
		var deck = Deck(cards: [1, 2, 3, 4, 5, 6])
		let expectedDeck = Deck(cards: [1, 3, 5, 2, 4, 6])

		var (evenDeck, oddDeck) = deck.split { $0 % 2 == 0 }
		XCTAssertTrue(deck.isEmpty)

		var composedDeck = Deck<Int>()
		composedDeck.placeOnTop(&oddDeck)
		composedDeck.placeOnBottom(&evenDeck)

		XCTAssertEqual(composedDeck, expectedDeck)
	}

	func testCopy() {
		let deck = Deck(cards: [1, 2, 3, 4, 5])
		let copyDeck = Deck(copy: deck)
		XCTAssertEqual(deck, copyDeck)
	}
}
