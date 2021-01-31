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
    
    private func dealSingleCard() {
        guard let randomIndex = allCards.indices.randomElement() else {
            return
        }
        var randomCard = allCards[randomIndex]
        randomCard.isDealt = true
        allCards[randomIndex] = randomCard
    }
}