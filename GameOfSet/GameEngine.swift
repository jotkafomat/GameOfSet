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
    
    public func startGame() {
        while dealtCards.count != 12 {
            dealSingleCard()
        }
    }
    
    public func select(_ card: Card) {
        
        if selectedCards.count > 2 {
            for index in allCards.indices {
                allCards[index].isSelected = false
            }
            // remove all matched
            // deal 3 cards if avaible
        }
        
        guard let selectedIndex = allCards.firstIndex(where: { card.matches($0) }) else {
            return
        }
        var selectedCard = allCards[selectedIndex]
        selectedCard.isSelected.toggle()
        allCards[selectedIndex] = selectedCard
        
        if selectedCards.areValidSet {
            for card in selectedCards {
                guard let matchedIndex = allCards.firstIndex(where: { card.matches($0) }) else {
                    return
                }
        
                var matchedCard = allCards[matchedIndex]
                matchedCard.isMatched = true
                allCards[matchedIndex] = matchedCard
            }
        }
    }
    
    private func dealSingleCard() {
        guard let randomIndex = allCards.indices.randomElement() else {
            return
        }
        var randomCard = allCards[randomIndex]
        randomCard.isDealt = true
        allCards[randomIndex] = randomCard
    }
    
    private var selectedCards: [Card] {
        allCards.filter({ $0.isSelected})
    }
}
