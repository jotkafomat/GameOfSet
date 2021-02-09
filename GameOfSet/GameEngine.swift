//
//  GameEngine.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import Foundation
import Combine

class GameEngine: ObservableObject {
    
    private var allCards: [Card]
    
    public init(allCards: [Card] = Card.newDeck) {
        self.allCards = allCards
    }
    
    public var dealtCards: [Card] {
        allCards.filter { $0.isDealt }
    }
    
    public var canDealMoreCards: Bool {
        allCards.filter({ !$0.isDealt }).isNotEmpty
    }
    
    public func startGame() {
        topUpDealtCards(to: 12)
    }
    
    public func touch(_ card: Card) {
        
        if selectedCards.count > 2 {
            deselectAllCards()
            removeAllMatched()
            // deal 3 cards if avaible
            topUpDealtCards(to: 12)
        }
        
        toggleIsSelected(card)
        markIfMatched()
    }
    
    public func deal3MoreCards() {
        let expectedDealtCardsCount = dealtCards.count + 3
        topUpDealtCards(to: expectedDealtCardsCount)
    }
    
    private func markIfMatched() {
        guard selectedCards.areValidSet else {
            return
        }
        for card in selectedCards {
            guard let matchedIndex = allCards.firstIndex(where: { card.matches($0) }) else {
                return
            }
            allCards[matchedIndex].isMatched = true
        }
    }
    
    private func deselectAllCards() {
        for index in allCards.indices {
            allCards[index].isSelected = false
        }
    }
    
    private func removeAllMatched() {
        allCards.removeAll(where: { $0.isMatched })
    }
    
    private func topUpDealtCards(to expectedCount: Int) {
        guard canDealMoreCards else {
            return
        }
        while dealtCards.count != expectedCount {
            dealSingleCard()
        }
    }
    
    private func toggleIsSelected(_ card: Card) {
        guard let selectedIndex = allCards.firstIndex(where: { card.matches($0) }) else {
            return
        }
        allCards[selectedIndex].isSelected.toggle()
    }
    
    private func dealSingleCard() {
        guard let randomIndex = allCards.indices.randomElement() else {
            return
        }
        allCards[randomIndex].isDealt = true
    }
    
    private var selectedCards: [Card] {
        allCards.filter({ $0.isSelected})
    }
}
