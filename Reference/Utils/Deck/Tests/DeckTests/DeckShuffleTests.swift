//
//  DeckShuffleTests.swift
//  
//
//  Created by Vladislav Maltsev on 03.01.2022.
//

import XCTest
import Deck

final class DeckShuffleTests: XCTestCase {
	func testRandomShuffle() {
		var emptyDeck = Deck<Int>(cards: [])
		emptyDeck.shuffle()
		XCTAssertEqual(emptyDeck, Deck<Int>(cards: []))

		var singleDeck = Deck(cards: [1])
		singleDeck.shuffle()
		XCTAssertEqual(singleDeck, Deck(cards: [1]))

		var deck = Deck(cards: [1, 2, 3, 4, 5])
		deck.shuffle()
		XCTAssertEqual(deck.count, 5)
		XCTAssertNotEqual(deck, Deck(cards: [1, 2, 3, 4, 5]))
	}

	func testSplitHalfAndSwitchShuffle() {
		var emptyDeck = Deck<Int>(cards: [])
		emptyDeck.shuffle(strategy: Shuffles.SplitHalfAndSwitch())
		XCTAssertEqual(emptyDeck, Deck<Int>(cards: []))

		var singleDeck = Deck(cards: [1])
		singleDeck.shuffle(strategy: Shuffles.SplitHalfAndSwitch())
		XCTAssertEqual(singleDeck, Deck(cards: [1]))

		var evenDeck = Deck(cards: [1, 2, 3, 4])
		evenDeck.shuffle(strategy: Shuffles.SplitHalfAndSwitch())
		XCTAssertEqual(evenDeck, Deck(cards: [3, 4, 1, 2]))

		var oddDeck = Deck(cards: [1, 2, 3, 4, 5])
		oddDeck.shuffle(strategy: Shuffles.SplitHalfAndSwitch())
		XCTAssertEqual(oddDeck, Deck(cards: [4, 5, 1, 2, 3]))
	}

	func testSplitHalfAndZipShuffle() {
		var emptyDeck = Deck<Int>(cards: [])
		emptyDeck.shuffle(strategy: Shuffles.SplitHalfAndZip())
		XCTAssertEqual(emptyDeck, Deck<Int>(cards: []))

		var singleDeck = Deck(cards: [1])
		singleDeck.shuffle(strategy: Shuffles.SplitHalfAndZip())
		XCTAssertEqual(singleDeck, Deck(cards: [1]))

		var evenDeck = Deck(cards: [1, 2, 3, 4])
		evenDeck.shuffle(strategy: Shuffles.SplitHalfAndZip())
		XCTAssertEqual(evenDeck, Deck(cards: [1, 3, 2, 4]))

		var oddDeck = Deck(cards: [1, 2, 3, 4, 5])
		oddDeck.shuffle(strategy: Shuffles.SplitHalfAndZip())
		XCTAssertEqual(oddDeck, Deck(cards: [1, 4, 2, 5, 3]))
	}

	func testAnyShuffle() {
		let anyShuffle = AnyShuffle<Int>(Shuffles.SplitHalfAndSwitch())
		var deck = Deck(cards: [1, 2, 3, 4])
		deck.shuffle(strategy: anyShuffle)
		XCTAssertEqual(deck, Deck(cards: [3, 4, 1, 2]))
	}
}
