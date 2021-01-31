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
    
}
