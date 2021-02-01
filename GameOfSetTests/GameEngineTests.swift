//
//  GameEngineTests.swift
//  GameOfSetTests
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import XCTest
@testable import GameOfSet

class GameEngineTests: XCTestCase {
    
    var subject: GameEngine!
    
    override func setUp() {
        subject = GameEngine()
    }
    
    override func tearDown() {
        subject = nil
    }
    
    
    func testStartGameDeals12Cards() throws {
        XCTAssertEqual(subject.dealtCards.count, 0)
        subject.startGame()
        XCTAssertEqual(subject.dealtCards.count, 12)
    }
    
    func testSelectCard() throws {
        subject.startGame()
        
        let card = try XCTUnwrap(subject.dealtCards.first)
        XCTAssertFalse(card.isSelected)
        
        subject.select(card)
        XCTAssertTrue(subject.dealtCards.first!.isSelected)
    }
    
    func testCanSelectUpTo3Cards() {
        subject.startGame()
        
        //select 3 cards
        subject.select(subject.dealtCards[0])
        subject.select(subject.dealtCards[3])
        subject.select(subject.dealtCards[7])
        
        //atempt selecting 4th card
        let card4 = subject.dealtCards[11]
        subject.select(card4)
        XCTAssertEqual(subject.dealtCards.filter({ $0.isSelected }).count, 3)
        XCTAssertFalse(subject.dealtCards.filter({ $0.isSelected }).contains(card4))
        XCTAssertFalse(subject.dealtCards[11].isSelected)
    }
    
    func testDeselectionWorksWhenLessThan3CardsSelected() {
        subject.startGame()
        
        //select 2 cards
        subject.select(subject.dealtCards[0])
        subject.select(subject.dealtCards[3])
        XCTAssertTrue(subject.dealtCards[0].isSelected)
        XCTAssertTrue(subject.dealtCards[3].isSelected)
        // deselect the same cards
        subject.select(subject.dealtCards[0])
        subject.select(subject.dealtCards[3])
        
        XCTAssertFalse(subject.dealtCards[0].isSelected)
        XCTAssertFalse(subject.dealtCards[3].isSelected)
    }
    
    
    func testDeselectionImpossibleWith3CardsSelected() {
        subject.startGame()
        
        //select 2 cards
        subject.select(subject.dealtCards[0])
        subject.select(subject.dealtCards[3])
        subject.select(subject.dealtCards[7])
        XCTAssertTrue(subject.dealtCards[0].isSelected)
        XCTAssertTrue(subject.dealtCards[3].isSelected)
        XCTAssertTrue(subject.dealtCards[7].isSelected)
        // attempt to deselect selected card
        subject.select(subject.dealtCards[0])
        //all cards are still selected
        XCTAssertTrue(subject.dealtCards[0].isSelected)
        XCTAssertTrue(subject.dealtCards[3].isSelected)
        XCTAssertTrue(subject.dealtCards[7].isSelected)
    }
    
    func testMatchingCardsAllDiffrentProperties() throws {
        
        //three matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .oval, number: .two, color: .green, shading: .solid, isDealt: true)
        let card3 = Card(shape: .squiggle, number: .three, color: .purple, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(with: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        subject.select(card1)
        subject.select(card2)
        subject.select(card3)
        
        let new1 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card1)}))
        let new2 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card2)}))
        let new3 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card3)}))
        XCTAssertTrue(new1.isMatched)
        XCTAssertTrue(new2.isMatched)
        XCTAssertTrue(new3.isMatched)
        
    }
    
    func testNonMatchingCards() throws {
        
        //three non matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .oval, number: .two, color: .green, shading: .solid, isDealt: true)
        let card3 = Card(shape: .diamond, number: .three, color: .purple, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(with: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        subject.select(card1)
        subject.select(card2)
        subject.select(card3)
        
        let new1 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card1)}))
        let new2 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card2)}))
        let new3 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card3)}))
        XCTAssertFalse(new1.isMatched)
        XCTAssertFalse(new2.isMatched)
        XCTAssertFalse(new3.isMatched)
        
    }
    
    func testMatchingCardsSomePropertiesSame() throws {
        
        //three matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .diamond, number: .two, color: .red, shading: .solid, isDealt: true)
        let card3 = Card(shape: .diamond, number: .three, color: .red, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(with: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        subject.select(card1)
        subject.select(card2)
        subject.select(card3)
        
        let new1 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card1)}))
        let new2 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card2)}))
        let new3 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card3)}))
        XCTAssertTrue(new1.isMatched)
        XCTAssertTrue(new2.isMatched)
        XCTAssertTrue(new3.isMatched)
        
    }
    
    private func prepareDeck(with cards: [Card]) -> [Card] {
        var deck = Card.newDeck
        //remove the 3 matching cards
        deck.removeAll(where: { cards.contains($0)})
        //chose first 9 cards
        deck = Array(deck.prefix(9))
        // add the 3 matching cards
        deck.append(contentsOf: cards)
        return deck
    }
}

extension Card {
    
    func matches(_ other: Card) -> Bool {
        color == other.color &&
            shape == other.shape &&
            number == other.number &&
            shading == other.shading
    }
}
