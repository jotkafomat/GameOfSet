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
        
        subject.touch(card)
        XCTAssertTrue(subject.dealtCards.first!.isSelected)
    }
    
    func testDeselectionWorksWhenLessThan3CardsSelected() {
        subject.startGame()
        
        //select 2 cards
        subject.touch(subject.dealtCards[0])
        subject.touch(subject.dealtCards[3])
        XCTAssertTrue(subject.dealtCards[0].isSelected)
        XCTAssertTrue(subject.dealtCards[3].isSelected)
        // deselect the same cards
        subject.touch(subject.dealtCards[0])
        subject.touch(subject.dealtCards[3])
        
        XCTAssertFalse(subject.dealtCards[0].isSelected)
        XCTAssertFalse(subject.dealtCards[3].isSelected)
    }

    
    func testMatchingCardsAllDiffrentProperties() throws {
        
        //three matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .oval, number: .two, color: .green, shading: .solid, isDealt: true)
        let card3 = Card(shape: .squiggle, number: .three, color: .purple, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
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
        
        let deck = prepareDeck(including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
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
        
        let deck = prepareDeck(including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
        let new1 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card1)}))
        let new2 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card2)}))
        let new3 = try XCTUnwrap(subject.dealtCards.first(where: { $0.matches(card3)}))
        XCTAssertTrue(new1.isMatched)
        XCTAssertTrue(new2.isMatched)
        XCTAssertTrue(new3.isMatched)
        
    }
    
    func testDeselectAllSelectedWhenFourthCardSelected() {
        subject.startGame()
        
        //select 3 cards
        subject.touch(subject.dealtCards[0])
        subject.touch(subject.dealtCards[3])
        subject.touch(subject.dealtCards[7])
        //select 4th
        subject.touch(subject.dealtCards[2])
        
        //initial 3 are deselected
        XCTAssertFalse(subject.dealtCards[0].isSelected)
        XCTAssertFalse(subject.dealtCards[3].isSelected)
        XCTAssertFalse(subject.dealtCards[7].isSelected)
        //4th is selected
        XCTAssertTrue(subject.dealtCards[2].isSelected)
    }
    
    func testDeselectAllSelectedWhenOneSelectedAgain() {
        subject.startGame()
        
        //select 3 cards
        subject.touch(subject.dealtCards[0])
        subject.touch(subject.dealtCards[3])
        subject.touch(subject.dealtCards[7])
        //select one again
        subject.touch(subject.dealtCards[3])
        
        //2 get deselected
        XCTAssertFalse(subject.dealtCards[0].isSelected)
        XCTAssertFalse(subject.dealtCards[7].isSelected)
        //one selected again stays selected
        XCTAssertTrue(subject.dealtCards[3].isSelected)
    }
    
    func testMatchingCardsGetRemovenWhenNextCardSelected() throws {
        
        //three matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .diamond, number: .two, color: .red, shading: .solid, isDealt: true)
        let card3 = Card(shape: .diamond, number: .three, color: .red, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        //select 3 macthing cards
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
        //tap on new card
        let nextCard = try XCTUnwrap(subject.dealtCards.first(where: { ![card1, card2, card3].contains($0) }))
        subject.touch(nextCard)
        
        //ensure matched cards were removed
        XCTAssertNil(subject.dealtCards.first(where: { $0.matches(card1)}))
        XCTAssertNil(subject.dealtCards.first(where: { $0.matches(card2)}))
        XCTAssertNil(subject.dealtCards.first(where: { $0.matches(card3)}))
    }
    
    
    func testDealExtraThreeCardsAfterMatch() throws {
        //three matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .diamond, number: .two, color: .red, shading: .solid, isDealt: true)
        let card3 = Card(shape: .diamond, number: .three, color: .red, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(of: 15, including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        //select 3 macthing cards
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
        //tap on new card
        let nextCard = try XCTUnwrap(subject.dealtCards.first(where: { ![card1, card2, card3].contains($0) }))
        subject.touch(nextCard)
        
        XCTAssertEqual(subject.dealtCards.count, 12)
    }
    
    func testDonotDealExtraThreeCardsAfterMatchIfNoneLeft() throws {
        //three matching cards
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .diamond, number: .two, color: .red, shading: .solid, isDealt: true)
        let card3 = Card(shape: .diamond, number: .three, color: .red, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        //select 3 macthing cards
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
        //tap on new card
        let nextCard = try XCTUnwrap(subject.dealtCards.first(where: { ![card1, card2, card3].contains($0) }))
        subject.touch(nextCard)
        
        XCTAssertEqual(subject.dealtCards.count, 9)
    }
    
    func testCanDealMoreCardsisFalseWhenThereAreNoCardsToDeal() {
        // Given a deck of 12 cards
        let deck = prepareDeck(including: [Card]())
        //start game
        let subject = GameEngine(allCards: deck)
        subject.startGame()
        
        XCTAssertFalse(subject.canDealMoreCards)
    }
    
    func testCanDealMoreCardsisTrueWhenThereAreCardsToDeal() {
        // Given a deck of 15 cards
        let deck = prepareDeck(of: 15, including: [Card]())
        //start game
        let subject = GameEngine(allCards: deck)
        subject.startGame()
        
        XCTAssertTrue(subject.canDealMoreCards)
    }
    
    func testDeal3MoreCards() {
        subject.startGame()
        let initialNumberOfDealtCards = subject.dealtCards.count
        subject.deal3MoreCards()
        XCTAssertEqual(subject.dealtCards.count, initialNumberOfDealtCards + 3)
    }
    
    func testDeal3MoreCardsWhenThereIsAMatch() {
        
        let card1 = Card(shape: .diamond, number: .one, color: .red, shading: .open, isDealt: true)
        let card2 = Card(shape: .diamond, number: .two, color: .red, shading: .solid, isDealt: true)
        let card3 = Card(shape: .diamond, number: .three, color: .red, shading: .striped, isDealt: true)
        
        let deck = prepareDeck(of: 15, including: [card1, card2, card3])
        
        let subject = GameEngine(allCards: deck)
        
        subject.startGame()
        
        //select 3 macthing cards
        subject.touch(card1)
        subject.touch(card2)
        subject.touch(card3)
        
        //tap button deal three more cards
        subject.deal3MoreCards()
        
        XCTAssertEqual(subject.dealtCards.count, 12)
        
        //ensure matched cards were removed
        XCTAssertNil(subject.dealtCards.first(where: { $0.matches(card1)}))
        XCTAssertNil(subject.dealtCards.first(where: { $0.matches(card2)}))
        XCTAssertNil(subject.dealtCards.first(where: { $0.matches(card3)}))
    }
    
    func testNewGame() {
        
        subject.startGame()
        
        let originalDealtCards = subject.dealtCards
        
        subject.newGame()
        XCTAssertEqual(subject.dealtCards.count, 12)
        XCTAssertNotEqual(originalDealtCards, subject.dealtCards)
    }
    
    private func prepareDeck(of number: Int = 12, including cards: [Card]) -> [Card] {
        var deck = Card.newDeck
        //remove the 3 matching cards
        for card in cards {
            deck.removeAll(where: { $0.matches(card)})
        }
        //keep only first X cards
        deck = Array(deck.prefix(number - cards.count))
        // add the 3 matching cards
        deck.append(contentsOf: cards)
        // return (number) cards including
        return deck
    }
}
