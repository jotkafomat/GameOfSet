//
//  CardTests.swift
//  GameOfSetTests
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import XCTest
@testable import GameOfSet

class CardTests: XCTestCase {

    func testCreateNewDeck() throws {
        let deck = Card.newDeck
        
        // new deck has 81 cards
        XCTAssertEqual(deck.count, 81)
        // all 81 cards are unique
        XCTAssertEqual(Set(deck).count, 81)
    }
}
