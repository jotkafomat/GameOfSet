//
//  GameEngineTests.swift
//  GameOfSetTests
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import XCTest
@testable import GameOfSet

class GameEngineTests: XCTestCase {
    
    
    func testStartGameDeals12Cards() throws {
        let subject = GameEngine()
        
        XCTAssertEqual(subject.dealtCards.count, 0)
        subject.startGame()
        XCTAssertEqual(subject.dealtCards.count, 12)
    }
    
    func testSelectCard() throws {
        let subject = GameEngine()
        subject.startGame()
        
        let card = try XCTUnwrap(subject.dealtCards.first)
        XCTAssertFalse(card.isSelected)
        
        subject.select(card)
        XCTAssertTrue(subject.dealtCards.first!.isSelected)
    }
    
}
