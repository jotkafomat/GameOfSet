//
//  GameEngine.swift
//  GameOfSet
//
//  Created by Krzysztof Jankowski on 31/01/2021.
//

import Foundation
import Combine

class GameEngine: ObservableObject {
    
    private var allCards = Card.newDeck
    
    public var dealtCards: [Card] {
        allCards.filter { $0.isDealt }
    }
    
    public func startGame() {
        while dealtCards.count != 12 {
            dealSingleCard()
        }
    }
    
    public func select(_ card: Card) {
        
        guard allCards.filter({ $0.isSelected}).count < 3 else {
            //TODO: check if selected form set
            return
        }
        
        guard let selectedIndex = allCards.firstIndex(of: card) else {
            return
        }
        var selectedCard = allCards[selectedIndex]
        selectedCard.isSelected.toggle()
        allCards[selectedIndex] = selectedCard
    }
    
    private func dealSingleCard() {
        guard let randomIndex = allCards.indices.randomElement() else {
            return
        }
        var randomCard = allCards[randomIndex]
        randomCard.isDealt = true
        allCards[randomIndex] = randomCard
    }
}
